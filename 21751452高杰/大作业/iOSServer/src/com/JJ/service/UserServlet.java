package com.JJ.service;

import com.JJ.dao.UserDao;
import com.JJ.model.User;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class UserServlet extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String method = request.getParameter("method");
        Map<String, Object> params = new HashMap<String, Object>();
        if (method != null) {
            if ("register".equalsIgnoreCase(method)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                UserDao dao = new UserDao();
                PrintWriter out = response.getWriter();
                if (username != null && !username.isEmpty()) {
                    if (dao.queryByUsername(username)) {
                        params.put("status", "-1");
                        out.print(params);
                    } else {
                        if (dao.insertUser(username, password)) {
                            params.put("status", "1");
                            JSONObject json = JSONObject.parseObject(JSON.toJSONString(params));
                            out.print(json);
                        } else {
                            params.put("status", "-1");
                            JSONObject json = JSONObject.parseObject(JSON.toJSONString(params));
                            out.print(json);
                        }
                    }
                }
            } else if ("login".equalsIgnoreCase(method)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                UserDao dao = new UserDao();
                User user = dao.findUser(username, password);
                PrintWriter out = response.getWriter();
                if (user != null) {
                    params.put("status", "1");
                    JSONObject json = JSONObject.parseObject(JSON.toJSONString(params));
                    out.print(json);
                } else {
                    params.put("status", "-1");
                    JSONObject json = JSONObject.parseObject(JSON.toJSONString(params));
                    out.print(json);
                }
            }
        }

    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

    }

}
