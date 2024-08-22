package com.kh.kh14semi3.service;

import java.io.File;



import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.kh14semi3.configuration.CustomFileUploadProperties;
import com.kh.kh14semi3.dao.AttachmentDao;
import com.kh.kh14semi3.dto.AttachmentDto;
import com.kh.kh14semi3.error.TargetNotFoundException;

import jakarta.annotation.PostConstruct;

@Service
public class AttachmentService {
	
	@Autowired
	private CustomFileUploadProperties properties;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(properties.getPath());
		dir.mkdirs();
	}
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	public int save(MultipartFile attach) throws IllegalStateException, IOException {
		int attachmentNo = attachmentDao.sequence();
		
		File target = new File(dir,String.valueOf(attachmentNo));
		attach.transferTo(target);
		
		AttachmentDto attachmentDto = new AttachmentDto();
		attachmentDto.setAttachmentNo(attachmentNo);
		attachmentDto.setAttachmentName(attach.getOriginalFilename());
		attachmentDto.setAttachmentType(attach.getContentType());
		attachmentDto.setAttachmentSize(attach.getSize());
		attachmentDao.insert(attachmentDto);
		
		return attachmentNo;
	}
			
	
	public void delete(int attachmentNo) {
		AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		if(attachmentDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 파일 번호");
		}
		
		File target = new File(dir, String.valueOf(attachmentNo));
	    target.delete();
	   
	   attachmentDao.delete(attachmentNo);
	   
	}
	public  ResponseEntity<ByteArrayResource>  find(int attachmentNo) throws IOException{
		 AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		 if(attachmentDto == null) {
			 throw new TargetNotFoundException("존재 하지 않는 파일 번호");
		 }
		
		 File target = new File(dir,String.valueOf(attachmentNo));
		 byte[] data =FileUtils.readFileToByteArray(target);
		 ByteArrayResource resource = new ByteArrayResource(data);
		 return ResponseEntity.ok()
				 .contentType(MediaType.APPLICATION_OCTET_STREAM)
				 .contentLength(attachmentDto.getAttachmentSize())
				 .header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				 .header(
						 HttpHeaders.CONTENT_DISPOSITION, 
						 ContentDisposition.attachment().
						 filename(attachmentDto.getAttachmentName(),StandardCharsets.UTF_8).build().toString())
				 .body(resource);
	}
	


	}
	
	
	
	
	
	

