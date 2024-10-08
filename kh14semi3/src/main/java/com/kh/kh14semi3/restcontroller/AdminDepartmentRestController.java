package com.kh.kh14semi3.restcontroller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.kh14semi3.dao.AdminDepartmentDao;
import com.kh.kh14semi3.dto.DepartmentDto;
@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/admin/department")
public class AdminDepartmentRestController {
		@Autowired
		private AdminDepartmentDao adminDepartmentDao;
		
		//코드 중복 검사
		@PostMapping("/checkDepartmentCode")
		public boolean checkDepartmentCode(@RequestParam String departmentCode) {
			DepartmentDto departmentDto =
					adminDepartmentDao.selectOneByDepartmentCode(departmentCode);
			return departmentDto==null;
		}
		
		//학과명 중복 검사
				@PostMapping("/checkDepartmentName")
				public boolean checkDepartmentName(@RequestParam String departmentName) {
					DepartmentDto departmentDto =
							adminDepartmentDao.selectOneByDepartmentName(departmentName);
					return departmentDto==null;
				}
		
}
