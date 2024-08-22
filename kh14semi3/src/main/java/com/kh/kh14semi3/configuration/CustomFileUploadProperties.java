package com.kh.kh14semi3.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;

import lombok.Data;


@Data
@Service
@ConfigurationProperties(prefix = "custom.fileupload")
public class CustomFileUploadProperties{
private String path;
}
