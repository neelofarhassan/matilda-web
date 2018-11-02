package org.unimelb.matilda.util;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.unimelb.matilda.model.Problem;

import com.fasterxml.jackson.databind.ObjectMapper;



public class FileUtil {
	

    
    public List<Problem> JSONToProblemConverter(String filePath) {
    	Resource resource = new ClassPathResource(filePath);
    	List<Problem> libraryProblems = new ArrayList<>();
    	try {
			InputStream resourceInputStream = resource.getInputStream();
			ObjectMapper mapper = new ObjectMapper();
			libraryProblems = Arrays.asList(mapper.readValue(resourceInputStream, Problem[].class));
    	}catch(Exception e) {
    		}
    	return libraryProblems;
    	}
    	
}
