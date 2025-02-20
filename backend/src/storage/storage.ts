import { Injectable } from '@nestjs/common';
import {
  DeleteObjectCommand,
  GetObjectCommand,
  PutObjectCommand,
  S3Client,
  HeadBucketCommand,
  CreateBucketCommand,
  HeadObjectCommand,
} from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';
import { randomUUID } from 'crypto';
import { StorageConfig } from './storage.config';

@Injectable()
export abstract class StorageRepository {
  constructor(private readonly storageConfig: StorageConfig) {
    this.bucketName = this.getBucketName();
    this.ensureBucketExists();
  }

  protected abstract getBucketName(): string;
  protected bucketName: string;

  private readonly s3Client = new S3Client({
    credentials: {
      accessKeyId: this.storageConfig.accessKeyId,
      secretAccessKey: this.storageConfig.secretAccessKey,
    },
    endpoint: this.storageConfig.endpoint,
    forcePathStyle: this.storageConfig.isForcePathStyle,
    region: this.storageConfig.region,
  });

  private async ensureBucketExists(): Promise<void> {
    try {
      await this.s3Client.send(
        new HeadBucketCommand({ Bucket: this.bucketName }),
      );
    } catch (error) {
      if (error.name === 'NotFound') {
        console.log(`Bucket ${this.bucketName} does not exist. Creating...`);
        await this.s3Client.send(
          new CreateBucketCommand({ Bucket: this.bucketName }),
        );
        console.log(`Bucket ${this.bucketName} created.`);
      } else if (error.name === '403') {
        console.error(
          'Access to S3 storage is forbidden. It may appear if S3_ACCESS_KEY_ID and S3_SECRET_ACCESS_KEY environment variables are invalid',
        );
      } else {
        throw error;
      }
    }
  }

  async put(args: {
    filename: string;
    file: Buffer;
    generateFilename?: boolean;
  }): Promise<string> {
    if (args.generateFilename === undefined) args.generateFilename = false;

    let filename = args.filename;
    if (args.generateFilename === true) {
      filename = filename.replace(/[^a-zA-Z0-9]/g, '');
      filename = `${randomUUID()}-${filename}`;
    }

    try {
      await this.s3Client.send(
        new PutObjectCommand({
          Bucket: this.bucketName,
          Key: filename,
          Body: args.file,
        }),
      );
      return filename;
    } catch (error) {
      throw error;
    }
  }

  async getUrl(args: {
    objectKey: string;
    expiresIn?: number;
  }): Promise<string | undefined> {
    const { objectKey, expiresIn } = args;

    if ((await this.checkExistance({ objectKey })) === false) return undefined;

    try {
      const command = new GetObjectCommand({
        Bucket: this.bucketName,
        Key: objectKey,
      });
      const url = await getSignedUrl(this.s3Client, command, {
        expiresIn: expiresIn || 3600,
      });
      return url;
    } catch (error) {
      return undefined;
    }
  }

  async getUrls(args: {
    objectKeys: string[];
    expiresIn?: number;
  }): Promise<string[]> {
    const { objectKeys, expiresIn } = args;
    try {
      const urls: string[] = [];
      for (const key of objectKeys) {
        const url = await this.getUrl({ objectKey: key, expiresIn });
        urls.push(url);
      }
      return urls;
    } catch (error) {
      throw error;
    }
  }

  async update(args: { objectKey: string; file: Buffer }): Promise<string> {
    try {
      const filename = await this.put({
        filename: args.objectKey,
        file: args.file,
        generateFilename: false,
      });
      return filename;
    } catch (error) {
      throw error;
    }
  }

  async delete(args: { objectKey: string }): Promise<boolean> {
    try {
      const command = new DeleteObjectCommand({
        Bucket: this.bucketName,
        Key: args.objectKey,
      });
      await this.s3Client.send(command);
      return true;
    } catch (error) {
      return false;
    }
  }

  async checkExistance(args: { objectKey: string }): Promise<boolean> {
    try {
      const command = new HeadObjectCommand({
        Bucket: this.bucketName,
        Key: args.objectKey,
      });
      await this.s3Client.send(command);
      return true;
    } catch (error) {
      return false;
    }
  }
}
