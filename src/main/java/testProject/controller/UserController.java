package testProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import testProject.domain.User;
import testProject.service.UserService;

import java.sql.Date;
import java.util.List;

/**
 * Created by Tanya on 19.02.2016.
 */
@Controller
public class UserController {

    private UserPager userPager;
    private UserService userService;

    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Autowired(required = true)
    @Qualifier(value = "pager")
    public void setUserPager(UserPager userPager) {
        this.userPager = userPager;
    }

    @ModelAttribute("pageProperty")
    public UserPager createModel() {
        return this.userPager;
    }

    @RequestMapping(value = "/users")
    public String listUsers(@ModelAttribute("pageProperty") UserPager userPager, Model model) {
        User user = new User();
        user.setName(null);
        user.setAge(null);
        user.setIsAdmin(false);
        user.setCreatedDate(new Date(System.currentTimeMillis()));
        model.addAttribute("user", user);

        List<User> userList = userService.search(userPager.getNameFilter());
        Integer pageNumber = userPager.getPageNumber();
        PagedListHolder<User> pagedListHolder = new PagedListHolder<User>(userList);

        pagedListHolder.setPageSize(userPager.getPageSize());

        if ((pageNumber - 1) < 1 || pageNumber > pagedListHolder.getPageCount()) {
            userPager.setPageNumber(1);
            pagedListHolder.setPage(0);
            model.addAttribute("listUsers", pagedListHolder.getPageList());
        } else if (pageNumber <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(pageNumber - 1);
            model.addAttribute("listUsers", pagedListHolder.getPageList());
        }
        userPager.setSize(pagedListHolder.getPageCount());

        model.addAttribute("pageProperty", userPager);
        return "tableUser";
    }

    @RequestMapping("/")
    public String homePage(@ModelAttribute("pageProperty") UserPager userPager) {
        userPager.setPageNumber(1);
        userPager.setNameFilter("");
        return "redirect:/users";
    }

    @RequestMapping(value = "/user/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user) {
        if (user.getId() == 0) {
            this.userService.addUser(user);
        } else {
            this.userService.updateUser(user);
        }
        return "redirect:/users";
    }

    @RequestMapping("/remove/{id}")
    public String deleteUser(@PathVariable("id") Integer id) {
        this.userService.removeUser(id);
        return "redirect:/users";
    }

    @RequestMapping("/edit/{id}")
    public String updateUser(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("user", userService.getUserById(id));
        model.addAttribute("listUsers", this.userService.search(""));
        return "tableUser";
    }
}
