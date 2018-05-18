package com.hcrud.dao;

import com.hcrud.bean.Deparment;
import com.hcrud.bean.DeparmentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DeparmentMapper {
    long countByExample(DeparmentExample example);

    int deleteByExample(DeparmentExample example);

    int deleteByPrimaryKey(Integer deptId);

    int insert(Deparment record);

    int insertSelective(Deparment record);

    List<Deparment> selectByExample(DeparmentExample example);

    Deparment selectByPrimaryKey(Integer deptId);

    int updateByExampleSelective(@Param("record") Deparment record, @Param("example") DeparmentExample example);

    int updateByExample(@Param("record") Deparment record, @Param("example") DeparmentExample example);

    int updateByPrimaryKeySelective(Deparment record);

    int updateByPrimaryKey(Deparment record);
}