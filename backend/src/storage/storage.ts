import { Injectable } from '@nestjs/common';
import {
	DeleteObjectCommand,
	GetObjectCommand,
	PutObjectCommand,
	S3Client,
	HeadBucketCommand,
	CreateBucketCommand,
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
			} else {
				throw error;
			}
		}
	}

	async put(
		filename: string,
		file: Buffer,
		generateFilename: boolean = true,
	): Promise<string> {
		if (generateFilename === true) {
			filename = filename.replace(/[^a-zA-Z0-9]/g, '');
			filename = `${randomUUID()}-${filename}`;
		}
		try {
			await this.s3Client.send(
				new PutObjectCommand({
					Bucket: this.bucketName,
					Key: filename,
					Body: file,
				}),
			);
			return filename;
		} catch (error) {
			throw error;
		}
	}

	async getUrl(objectKey: string, expiresIn?: number): Promise<string> {
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
			throw error;
		}
	}

	async getUrls(objectKeys: string[], expiresIn?: number): Promise<string[]> {
		try {
			const urls: string[] = [];
			for (const key of objectKeys) {
				const url = await this.getUrl(key, expiresIn);
				urls.push(url);
			}
			return urls;
		} catch (error) {
			throw error;
		}
	}

	async update(objectKey: string, file: Buffer): Promise<string> {
		try {
			return await this.put(objectKey, file, false);
		} catch (error) {
			throw error;
		}
	}

	async delete(objectKey: string): Promise<void> {
		try {
			const command = new DeleteObjectCommand({
				Bucket: this.bucketName,
				Key: objectKey,
			});
			await this.s3Client.send(command);
			return;
		} catch (error) {
			throw error;
		}
	}
}
