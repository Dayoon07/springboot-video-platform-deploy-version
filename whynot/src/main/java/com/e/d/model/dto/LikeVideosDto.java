package com.e.d.model.dto;

import com.e.d.model.vo.LikeVo;
import com.e.d.model.vo.VideosVo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LikeVideosDto {
	private LikeVo like;
	private VideosVo videos;
}
