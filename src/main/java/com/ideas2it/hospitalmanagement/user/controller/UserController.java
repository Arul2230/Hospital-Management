package com.ideas2it.hospitalmanagement.user.controller;

import java.security.Principal;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ideas2it.hospitalmanagement.commons.Constants;
import com.ideas2it.hospitalmanagement.commons.enums.Role;
import com.ideas2it.hospitalmanagement.exception.ApplicationException;
import com.ideas2it.hospitalmanagement.logger.Logger;
import com.ideas2it.hospitalmanagement.user.model.User;
import com.ideas2it.hospitalmanagement.user.service.UserService;

/**
 * <p>
 * User Controller is a Controller Class, which is used authorise the user to access the application
 * and allow them to make modifications to the available data. Provides methods to implement basic
 * user operations like Login, Signup and Logout operations.
 * </p>
 *
 * @author Rahul Ravi
 * @version 1.0
 */
@Controller
public class UserController {

    private UserService userService = null;

    public void setUserService(final UserService userService) {
        this.userService = userService;
    }

    public UserService getUserService() {
        return this.userService;
    }

    /**
     * This Method is used to obtain the user Credentials during login and create a new Session.
     *
     * @param email    a String indicating the email Id entered by the user while logging in.
     * @param password a String indicating the password entered by the user while logging in.
     * @param role     a String indicating the role of the user that is logging in.
     */
    @RequestMapping(value = Constants.SIGNUP_PATH, method = RequestMethod.POST)
    private ModelAndView createUser(final Model model, @RequestParam(Constants.EMAIL) final String email,
            @RequestParam(Constants.PASSWORD) final String password,
            @RequestParam(value = Constants.ROLE, required = false) final String role) {
        try {
            if (null != userService.retrieveUserByEmail(email)) {
                if (null == role) {
                    return new ModelAndView(Constants.LOGIN, Constants.USER_FAIL, Constants.SIGNIN_USER_FAIL_MESSAGE);
                } else {
                    return new ModelAndView(Constants.ADMIN, Constants.USER_FAIL, Constants.MESSAGE);
                }
            } else {
                final User user = new User();
                user.setEmail(email);
                user.setPassword(password);
                if (null == role) {
                    user.setRole(Role.ADMIN.toString());
                } else {
                    user.setRole(role);
                }
                if (userService.addUser(user)) {
                    return new ModelAndView(Constants.ADMIN, Constants.MESSAGE, Constants.SIGN_UP_SUCCESS_MESSAGE);
                } else if (null == role) {
                    return new ModelAndView(Constants.LOGIN, Constants.USER_FAIL, Constants.SIGN_UP_FAIL_MESSAGE);
                } else {
                    return new ModelAndView(Constants.ADMIN, Constants.MESSAGE, Constants.SIGN_UP_FAIL_MESSAGE);
                }
            }
        } catch (final ApplicationException e) {
            Logger.error(e);
            return new ModelAndView(Constants.LOGIN_JSP, Constants.SIGN_UP_FAIL, Constants.USER_ADD_EXCEPTION);
        }
    }

    /**
     * This Method is used to display all details of the users in JSON format.
     *
     * @return String a String object which is used to redirect or send text output.
     */
    @RequestMapping(value = Constants.DISPLAY_USERS_MAPPING, produces = { Constants.JSON_TYPE,
            Constants.XML_TYPE }, consumes = Constants.JSON_TYPE, headers = Constants.FORM_HEADER, method = RequestMethod.GET)
    private @ResponseBody String displayAllUsers(final Model model, @RequestParam(Constants.QUERY) final String query) {
        try {
            return new Gson().toJson(userService.retrieveUsersByQuery(query, Role.PHYSICIAN.toString()));
        } catch (final ApplicationException e) {
            Logger.error(e);
            return null;
        }
    }

    /**
     * This Method is used to display details of single user in json Format.
     *
     * @return String a String object used to redirect it to a view such as a jsp page.
     */
    @RequestMapping(value = Constants.SEARCH_USER_MAPPING, produces = { Constants.JSON_TYPE,
            Constants.XML_TYPE }, consumes = Constants.JSON_TYPE, headers = Constants.FORM_HEADER, method = RequestMethod.GET)
    private @ResponseBody String searchUser(final Model model, @RequestParam(Constants.EMAIL) final String email) {
        try {
            return new Gson().toJson(userService.retrieveUsersByQuery(email, Role.ADMIN.toString()));
        } catch (final ApplicationException e) {
            Logger.error(e);
            return null;
        }
    }

    /**
     * This Method is used to redirect user to respective login pages based on their roles
     *
     * @return String a String object which is used to redirect or send text output.
     */
    @RequestMapping(value = Constants.INDEX_MAPPING, method = RequestMethod.GET)
    public String userInfo(final Model model, final Principal principal, final HttpServletRequest request) {
        model.addAttribute(Constants.EMAIL, principal.getName());
        final HttpSession oldSession = request.getSession(Boolean.FALSE);
        if (null != oldSession) {
            oldSession.invalidate();
        }
        final HttpSession session = request.getSession();
        session.setAttribute(Constants.EMAIL, principal.getName());
        session.setMaxInactiveInterval(Constants.SESSION_ACTIVE_INTERVAL);
        final Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
                .getContext().getAuthentication().getAuthorities();
        if (authorities.iterator().next().toString().equals(Constants.ADMIN_ROLE)) {
            return Constants.ADMIN_INDEX;
        } else if (authorities.iterator().next().toString().equals(Constants.PHYSICIAN_ROLE)) {
            return Constants.PHYSICIAN_INDEX;
        } else if (authorities.iterator().next().toString().equals(Constants.NURSE_ROLE)) {
            return Constants.NURSE_INDEX;
        } else if (authorities.iterator().next().toString().equals(Constants.RECEPTIONIST_ROLE)) {
            return Constants.RECEPTIONIST_INDEX;
        } else {
            return Constants.ACCESS_DENIED_JSP;
        }
    }

    /**
     * This Method is used to display all details of the users.
     *
     * @return modelAndView a ModelAndView object which is used to add attributes to a model and
     *         redirect it to a view such as a jsp page.
     */
    @RequestMapping(Constants.ACCESS_DENIED_MAPPING)
    public String accessDenied(final Model model, final Principal principal) {
        if (principal != null) {
            model.addAttribute(Constants.EMAIL, principal.getName());
        }
        return Constants.ACCESS_DENIED_JSP;
    }

    /**
     * This Method is used to redirect the user to Login page.
     *
     * @param response a HttpServletResponse object which is used to redirect or send text output.
     * @return modelAndView a ModelAndView object which is used to add attributes to a model and
     *         redirect it to a view such as a jsp page.
     */
    @RequestMapping(value = { Constants.LOGIN_PATH, Constants.EMPTY_URI, Constants.LOGOUT_PATH,
            Constants.LOGOUT_SUCCESS_MAPPING })
    public String redirectLogin(final Model model, final Principal principal, final HttpServletRequest request,
            final HttpServletResponse response) {
        if (principal == null) {
            final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null) {
                new SecurityContextLogoutHandler().logout(request, response, auth);
            }
            return "login";
        } else {
            return userInfo(model, principal, request);
        }
    }

    /**
     * This Method is used to redirect user to Create User Jsp.
     *
     * @return String a String indicating the view for User Creation.
     */
    @RequestMapping(value = Constants.CREATE_USER_MAPPING)
    public String redirectCreateUser(final Model model) {
        model.addAttribute(Constants.ROLES, Role.values());
        model.addAttribute(Constants.USER, new User());
        return Constants.CREATE_USER_JSP;
    }

    /**
     * This Method is used to display all details of the users.
     *
     * @return modelAndView a ModelAndView object which is used to add attributes to a model and
     *         redirect it to a view such as a jsp page.
     */
    @RequestMapping(value = Constants.DISPLAY_USER_MAPPING, method = RequestMethod.GET)
    private ModelAndView displayAllUsers(final Model model) {
        try {
            final List<User> users = userService.retrieveAllUsers();
            model.addAttribute(Constants.NUMBER_OF_USERS, users.size());
            return new ModelAndView(Constants.USER_DISPLAY_JSP, Constants.USERS, users);
        } catch (final ApplicationException e) {
            Logger.error(e);
            return null;
        }
    }

    /**
     * This Method is used to restore a deleted user. Redirects to display all users on successful
     * restoration.
     *
     * @param id an Integer indicating the id of the user to be restored or reactivated.
     * @return modelAndView a ModelAndView object which is used to add attributes to a model and
     *         redirect it to a view such as a jsp page.
     */
    @RequestMapping(value = Constants.RESTORE_USER_MAPPING, method = RequestMethod.POST)
    private ModelAndView restoreUser(@RequestParam(Constants.ID) final int id, final Model model) {
        try {
            if (userService.restoreUser(id)) {
                model.addAttribute(Constants.MESSAGE, Constants.USER_RESTORE_SUCCESS_MESSAGE);
                return new ModelAndView(Constants.DISPLAY_USER_JSP, Constants.USERS, userService.retrieveAllUsers());
            } else {
                return new ModelAndView(Constants.ERROR_JSP, Constants.ERROR_MESSAGE, Constants.USER_EDIT_EXCEPTION);
            }
        } catch (final ApplicationException e) {
            Logger.error(e);
            return new ModelAndView(Constants.ERROR_JSP, Constants.ERROR_MESSAGE,
                    String.format(Constants.USER_RESTORE_EXCEPTION, id));
        }
    }

    /**
     * <p>
     * Method to update existing User Details. Returns true if the entry is modified successfully, else
     * returns false if the entry is not found.
     * </p>
     *
     * @param id an Integer indicating the id of the user to be modified.
     * @return modelAndView a ModelAndView object which is used to add attributes to a model and
     *         redirect it to a view such as a jsp page.
     */
    @RequestMapping(value = Constants.MODIFY_USER_MAPPING, method = RequestMethod.GET)
    private ModelAndView modifyUser(@RequestParam(Constants.ID) final int id, final Model model) {
        try {
            model.addAttribute(Constants.ROLES, Role.values());
            return new ModelAndView(Constants.CREATE_USER_JSP, Constants.USER, userService.retrieveUserById(id));
        } catch (final ApplicationException e) {
            Logger.error(e);
            return new ModelAndView(Constants.ERROR_JSP, Constants.ERROR_MESSAGE,
                    String.format(Constants.USER_EDIT_EXCEPTION, id));
        }
    }

    /**
     * <p>
     * Method to update existing User Details. Returns true if the entry is modified successfully, else
     * returns false if the entry is not found.
     * </p>
     *
     * @param user an User object with the updated details of the user.
     * @return modelAndView a ModelAndView object which is used to add attributes to a model and
     *         redirect it to a view such as a jsp page.
     */
    @RequestMapping(value = Constants.UPDATE_USER_MAPPING, method = RequestMethod.POST)
    private ModelAndView updateUser(@ModelAttribute final User user, final Model model) {

        try {
            if (!userService.modifyUser(user)) {
                return new ModelAndView(Constants.ERROR_JSP, Constants.ERROR_MESSAGE, Constants.EDIT_FAILED);
            }
            model.addAttribute(Constants.MESSAGE, Constants.USER_UPDATE_SUCCESS_MESSAGE);
            return new ModelAndView(Constants.DISPLAY_USER_JSP, Constants.USERS, userService.retrieveAllUsers());
        } catch (final ApplicationException e) {
            Logger.error(e);
            return new ModelAndView(Constants.ERROR_JSP, Constants.ERROR_MESSAGE,
                    String.format(Constants.USER_EDIT_EXCEPTION, user.getId()));
        }
    }

    /**
     * This Method is used to remove an existing user by Id given by the user.
     *
     * @param idToDelete an Integer indicating the id of the user to be deleted.
     * @return modelAndView a ModelAndView object which is used to add attributes to a model and
     *         redirect it to a view such as a jsp page.
     */
    @RequestMapping(value = Constants.DELETE_USER_MAPPING, method = RequestMethod.POST)
    private ModelAndView removeUser(@RequestParam(Constants.ID) final int idToDelete, final Model model) {
        try {
            if (!userService.deleteUser(idToDelete)) {
                return new ModelAndView(Constants.ERROR_JSP, Constants.ERROR_MESSAGE, Constants.USER_DELETE_EXCEPTION);
            }
            model.addAttribute(Constants.MESSAGE, Constants.USER_DELETE_SUCCESS_MESSAGE);
            return new ModelAndView(Constants.DISPLAY_USER_JSP, Constants.USERS, userService.retrieveAllUsers());
        } catch (final ApplicationException e) {
            Logger.error(e);
            return new ModelAndView(Constants.ERROR_JSP, Constants.ERROR_MESSAGE,
                    String.format(Constants.USER_DELETE_EXCEPTION, idToDelete));
        }
    }
}
