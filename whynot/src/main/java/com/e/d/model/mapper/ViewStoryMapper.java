package com.e.d.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.e.d.model.dto.ViewStoryVideosDto;

@Mapper
public interface ViewStoryMapper {
	List<ViewStoryVideosDto> myViewStorySelect(long id);
}
