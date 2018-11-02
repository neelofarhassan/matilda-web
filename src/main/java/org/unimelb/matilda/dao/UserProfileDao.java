package org.unimelb.matilda.dao;

import java.util.List;
 
import org.unimelb.matilda.model.UserProfile;
 
 
public interface UserProfileDao {
 
    List<UserProfile> findAll();
     
    UserProfile findByType(String type);
     
    UserProfile findById(int id);
}