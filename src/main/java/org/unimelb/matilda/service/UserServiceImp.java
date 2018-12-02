package org.unimelb.matilda.service;


 
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.unimelb.matilda.dao.UserDao;
import org.unimelb.matilda.model.User;
 

 
 
@Service("userService")
@Transactional
public class UserServiceImp implements UserService{
 
    @Autowired
    private UserDao userDao;
    @Autowired
    MailService mailService;
 
    @Autowired
    private PasswordEncoder passwordEncoder;
     
    public User findById(int id) {
        return userDao.findById(id);
    }
 
    public User findBySSO(String sso) {
        User user = userDao.findBySSO(sso);
        return user;
    }
    
    public void saveUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userDao.save(user);
        mailService.sendRegistrationEmail(user);
    }
    
    /*
     * Since the method is running with Transaction, No need to call hibernate update explicitly.
     * Just fetch the entity from db and update it with proper values within transaction.
     * It will be updated in db once transaction ends. 
     */
    public void updateUser(User user) {
        User entity = userDao.findById(user.getId());
        if(entity!=null){
            entity.setSsoId(user.getSsoId());
            if(!user.getPassword().equals(entity.getPassword())){
                entity.setPassword(passwordEncoder.encode(user.getPassword()));
            }
            entity.setFirstName(user.getFirstName());
            entity.setLastName(user.getLastName());
            entity.setEmail(user.getEmail());
            entity.setUserProfiles(user.getUserProfiles());
        }
    }
 
    public void updateUserStatus(User user) {
    	userDao.update(user);
    }
     
    public void deleteUserBySSO(String sso) {
    	userDao.deleteBySSO(sso);
    }
    
    public List<User> findAllUsers() {
        return userDao.findAllUsers();
    }
 
    public List<User> findUsersByStatus(String status){
    	List<User> users = new ArrayList<>();
    	return users;
    }
    public boolean isUserSSOUnique(Integer id, String sso) {
        User user = findBySSO(sso);
        return ( user == null || ((id != null) && (user.getId() == id)));
    }
     
}

