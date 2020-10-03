package com.service.impl;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.model.FetchDto;
import com.model.TokenDetails;
import com.model.Tweet;
import com.model.Tweets;
import com.service.TwitterService;
import com.utils.TokenUtils;

@Component
public class TwitterServiceImpl implements TwitterService{
	@Autowired
	private TokenUtils tokenUtils;

	@Override
	public List<Tweet> fetchFollowersTweets(FetchDto fetchDto) {
		List<Tweet> listTweet = new ArrayList<Tweet>();
		try {
			
			 listTweet = fetchAllFollowersTweets(tokenUtils.generateToken(),fetchDto);
		
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return listTweet;
	}

	@Override
	public List<Tweet> fetchTweets(FetchDto fetchDto) {
		List<Tweet> listTweet = new ArrayList<Tweet>();
		try {
			listTweet = fetchAllTweets(tokenUtils.generateToken(),fetchDto);
			
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return listTweet;
	}

	@Override
	public  List<Tweet> fetchHashTagTweets(FetchDto fetchDto) {
		List<Tweet> listTweet = new ArrayList<Tweet>();
		try {
			
			listTweet = fetchAllHashTagTweets(tokenUtils.generateToken(),fetchDto);
			
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		return listTweet;
	}
	
	public List<Tweet> fetchAllFollowersTweets(TokenDetails tokenDetails, FetchDto fetchDto) {
		
		RestTemplate restTemplate = new RestTemplate();
	
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + tokenDetails.getAccessToken());
		HttpEntity<String> entity = new HttpEntity<>(headers);
		
		String url = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name="+fetchDto.getScreenName()+"&count=20";
		
		ResponseEntity<List<Tweet>> response =
		    restTemplate.exchange(url,
		                          HttpMethod.GET,
		                          entity,
		                          new ParameterizedTypeReference<List<Tweet>>() {
								});
		
		//System.out.println("Access Token Response ---------" + response.getBody().get(0).getId());
		List<Tweet> list = response.getBody();
		//Tweets tweets = new Tweets(response.getBody());
		
		//System.out.println("Access Token Response ---------" + tweets.getTweets().get(0).toString());

		return list;
	}
	
	public List<Tweet> fetchAllHashTagTweets(TokenDetails tokenDetails,FetchDto fetchDto) {
		
		RestTemplate restTemplate = new RestTemplate();
	
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + tokenDetails.getAccessToken());
		HttpEntity<String> entity = new HttpEntity<>(headers);
		
		String url = "https://api.twitter.com/1.1/search/tweets.json?q=%23"+fetchDto.getHashtag()+"&result_type=recent";
		ResponseEntity<Tweets> response =
		    restTemplate.exchange(url,
		                          HttpMethod.GET,
		                          entity,
		                          Tweets.class);
		
		return response.getBody().getStatuses();
	}

	public List<Tweet> fetchAllTweets(TokenDetails tokenDetails,FetchDto fetchDto) {
		
		RestTemplate restTemplate = new RestTemplate();
	
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + tokenDetails.getAccessToken());
		HttpEntity<String> entity = new HttpEntity<>(headers);
		
		String url = "https://api.twitter.com/1.1/search/tweets.json?q=from%3A"+fetchDto.getScreenName()+"%20%23"+fetchDto.getHashtag()+"&result_type=recent";
		ResponseEntity<Tweets> response =
		    restTemplate.exchange(url,
		                          HttpMethod.GET,
		                          entity,
		                          Tweets.class);
		
		return response.getBody().getStatuses();
		
	}

}
