package com.e.d.model.mapper;

import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import com.e.d.model.vo.LikeVo;

@Mapper
public interface LikeMapper {
	long countVideoLikes(long id);
	Optional<LikeVo> likeOrNot(long likeVdoId, long likerId);
}
