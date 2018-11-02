package org.unimelb.matilda.converter;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import org.unimelb.matilda.model.UserProfile;
import org.unimelb.matilda.service.UserProfileService;
 
/**
 * A converter class used in views to map id's to actual userProfile objects.
 */
@Component
public class RoleToUserProfileConverter implements Converter<Object, UserProfile>{
 
    static final Logger logger = Logger.getLogger(RoleToUserProfileConverter.class);
     
    @Autowired
    UserProfileService userProfileService;
 
    /**
     * Gets UserProfile by Id
     * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
     */
    public UserProfile convert(Object element) {
        Integer id = Integer.parseInt((String)element);
        UserProfile profile= userProfileService.findById(id);
        logger.info("Profile : {}" + profile);
        return profile;
    }
     
}