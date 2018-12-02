package org.unimelb.matilda.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;
import org.unimelb.matilda.model.ALgorithmicFootPrint;

@Component
public class FileValidator implements Validator {

	public boolean supports(Class<?> clazz) {
		  return ALgorithmicFootPrint.class.isAssignableFrom(clazz);
		 }

		 public void validate(Object target, Errors errors) {
			 ALgorithmicFootPrint algorithmicFootPrint = (ALgorithmicFootPrint) target;
		  
		  MultipartFile performanceFile =algorithmicFootPrint.getPerformanceFile(); 
		  
		   if(performanceFile.getSize() == 0) {
		    errors.rejectValue("performanceFile", "missing.file");
		   }
		 }
}