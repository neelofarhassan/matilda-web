package org.unimelb.matilda.service;

import java.util.List;

import org.unimelb.matilda.model.UserProfile;
 
public interface UserProfileService {
 
    UserProfile findById(int id);
 
    UserProfile findByType(String type);
     
    List<UserProfile> findAll();
     
}
