package com.e.d.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.e.d.model.dto.CreatorSubscriptionDto;

@Mapper
public interface CreatorMapper {
	List<CreatorSubscriptionDto> selectBySubscribeUsername(String name, long id);
}
