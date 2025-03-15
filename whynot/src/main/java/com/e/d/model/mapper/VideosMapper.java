package com.e.d.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.e.d.model.dto.LikeVideosDto;
import com.e.d.model.vo.VideosVo;

@Mapper
public interface VideosMapper {
	long sumByMyVideoViews(long creatorVal);
	long sumByMyVideoLikes(long creatorVal);
	int updateLike(long likes, long videoId);
	List<LikeVideosDto> selectByMyLikeVideo(long id);
	List<VideosVo> search(String searchWord);
	List<VideosVo> allVideo();
}
