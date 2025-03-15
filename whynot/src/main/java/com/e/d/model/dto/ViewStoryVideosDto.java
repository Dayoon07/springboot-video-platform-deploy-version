package com.e.d.model.dto;

import com.e.d.model.vo.VideosVo;
import com.e.d.model.vo.ViewStoryVo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ViewStoryVideosDto {
	private ViewStoryVo viewStoryVo;
	private VideosVo videosVo;
}
