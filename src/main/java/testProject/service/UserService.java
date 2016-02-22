package testProject.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import testProject.dao.UserDao;
import testProject.domain.User;

import java.util.List;

/**
 * Created by Tanya on 19.02.2016.
 */
@Service
public class UserService {

    private UserDao userDao;

    public void setUserDAO(UserDao userDAO) {
        this.userDao = userDAO;
    }

    @Transactional
    public void addUser(User user) {
        this.userDao.addUser(user);
    }

    @Transactional
    public void removeUser(Integer id) {
        this.userDao.removeUser(id);
    }

    @Transactional
    public void updateUser(User user) {
        this.userDao.updateUser(user);
    }

    @Transactional
    public User getUserById(Integer id) {
        return this.userDao.getUserById(id);
    }

    @Transactional
    public List<User> search(String searchText){
        return this.userDao.search(searchText);
    }
}
