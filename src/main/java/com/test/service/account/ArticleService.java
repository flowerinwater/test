package com.test.service.account;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.utils.DateProvider;

import com.test.entity.ApnMessage;
import com.test.entity.Article;
import com.test.repository.ArticleDao;
import com.test.repository.MessageDao;

/**
 * 用户管理类.
 * 
 */
// Spring Service Bean的标识.
@Component
@Transactional(readOnly = true)
public class ArticleService {

	public static final String HASH_ALGORITHM = "SHA-1";
	public static final int HASH_INTERATIONS = 1024;
	private static final int SALT_SIZE = 8;

	private static Logger log = LoggerFactory.getLogger(ArticleService.class);

	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private MessageDao messageDao;
	private DateProvider dateProvider = DateProvider.DEFAULT;

	public List<Article> getAllArticle() {
		return (List<Article>) articleDao.findAll();
	}

	public Article getArticle(Long id) {
		return articleDao.findOne(id);
	}

	public List<Article> findArticleByLoginName(String loginName) {
		return articleDao.findByPublisherId(loginName);
	}

	@Transactional(readOnly = false)
	public void saveArticle(Article article) {
		System.out.println("111111111111111111");
		article.setPublishTime(dateProvider.getDate());
		
		ApnMessage msg = new ApnMessage();
		msg.setContent(article.getContent());
		msg.setCreateTime(dateProvider.getDate());
		msg.setReceiverId(article.getPublisherId());
		msg.setSenderId(article.getPublisherId());
		msg.setSenderName(article.getPublisherId());
		msg.setSrcapp("blog");
		msg.setStatus("0");
		msg.setTitle("title:");
		msg.setType("blog");
		messageDao.save(msg);
		log.info("2222222222222222222");
		articleDao.save(article);
	}

	@Transactional(readOnly = false)
	public void updateArticle(Article article) {
		article.setPublishTime(dateProvider.getDate());
		articleDao.save(article);
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		articleDao.delete(id);
	}

	public void setDateProvider(DateProvider dateProvider) {
		this.dateProvider = dateProvider;
	}

	public void setArticleDao(ArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	public void setMessageDao(MessageDao messageDao) {
		this.messageDao = messageDao;
	}
	
	
}
