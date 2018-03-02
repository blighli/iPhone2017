package com.JJ.dao;

import com.JJ.model.User;
import com.JJ.util.MybatisUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.Map;

public class UserDao {
    SqlSession sqlSession ;
    public boolean queryByUsername(String username){
        sqlSession = MybatisUtil.getSqlSession();
        boolean exist = false;
        try{
            User user = sqlSession.selectOne("com.JJ.map.queryByUsername",username);
            if (user!=null){
                exist = true;
            }
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            MybatisUtil.closeSession(sqlSession);
        }
        return exist;
    }
    public boolean insertUser(String username,String password){
        sqlSession = MybatisUtil.getSqlSession();
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        try{
            sqlSession.insert("com.JJ.map.insertUser",user);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            MybatisUtil.closeSession(sqlSession);
        }
        return true;
    }
    public User findUser(String username,String password) {
        User user = null;
        sqlSession = MybatisUtil.getSqlSession();
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("username",username);
        map.put("password",password);
        try{
            user = sqlSession.selectOne("com.JJ.map.findUser",map);
            sqlSession.commit();
        }catch (Exception e){
            e.printStackTrace();
            return user;
        }finally {
            MybatisUtil.closeSession(sqlSession);
        }
        return user;
    }

}
