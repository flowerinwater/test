package com.test.web.account;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.test.entity.Article;
import com.test.service.account.AccountService;
import com.test.service.account.ArticleService;
import com.test.util.PicCompression;

@Controller
public class BlogController {

	private static Logger log = LoggerFactory
			.getLogger(BlogController.class);

	String uploadPath = "c://";
	
	@Autowired
	private ArticleService articleService ;
	
	@Autowired
	private AccountService accountService ;
	
	@RequestMapping("/getblogs")
    @ResponseBody
	public JsonArrayResult<Article> getblogs(HttpServletRequest request){
		log.info("getblogs");
    	
    	JsonArrayResult<Article> lr = new JsonArrayResult<Article>();
    	
    	try{
    		List<Article> as = articleService.getAllArticle();
    		
    		if(as!=null){
    			lr.setResults(new Article[as.size()]);
    			
    			for (int i = 0; i < as.size(); i++) {
					lr.getResults()[i] = as.get(i);
				}
    		}
    		
	    	lr.setSuccess(true);
    	}catch(Exception e){
    		e.printStackTrace();
    		lr.setSuccess(false);
    		lr.setMsg(e.getMessage());
    	}

    	return lr;
    }
	
	@RequestMapping(value = "/sendblog", method = RequestMethod.POST)
	@ResponseBody
	public JsonSimpleResult uploadSolver(
			MultipartHttpServletRequest request) {
		JsonSimpleResult info = new JsonSimpleResult();
		
		Article article = new Article();
		article.setContent(request.getParameter("blogContent"));
		article.setPublisherId(request.getParameter("publisher"));
		
//		String dateFormat = "yyyy-MM-dd hh:mm:ss";
	    Calendar c = Calendar.getInstance();
//	    SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
//	    String msgDate = sdf.format(c.getTime());
	    article.setPublishTime(c.getTime());
	    
//	    User u = accountService.findUserByLoginName(article.getPublisherId());
//	    if(u!=null){
//	    	article.setUserid(u.getId());
//	    }
	    
		int attachmentType = Integer.parseInt(request.getParameter("attachmentType"));
		String attachMentField = null;
		if(attachmentType==0){
			
		}else if(attachmentType==1){
			attachMentField = "img";
			article.setImg(request.getParameter("blogContent"));
		}else if(attachmentType==2){
			attachMentField = "video";
			article.setVideo(request.getParameter("blogContent"));
		}
		
		if(attachMentField != null){
			MultipartFile patch = request.getFile(attachMentField);
			if (!patch.isEmpty()) {
				try {
					String fileName = patch.getOriginalFilename();
	
					/**
					 * 获取文件后缀
					 */
					log.info(fileName);
	
					File filePath = new File(uploadPath);
					System.out.println(filePath.getAbsolutePath());
					/**
					 * 判读存储文件路是否存在，不存在则创建
					 */
					if (!filePath.exists()) {
						filePath.mkdirs();
						log.info("上传文件路径不存在，创建成功！");
					}
					/**
					 * 文件开始上传到服务器上
					 */
					patch.transferTo(new File(filePath.getAbsolutePath() + "\\" + fileName));
					
					if(attachmentType==1){
						article.setImg(uploadPath + fileName);
						
						//生成缩略图200*200
						String filePrex = fileName
								.substring(0, fileName.lastIndexOf('.'));
						String newFile = filePrex + "_t"
								+ fileName.substring(filePrex.length());
						PicCompression.reduceImg(uploadPath + fileName, uploadPath + newFile, 200, 200, true);
						
					}else if(attachmentType==2){
						article.setVideo(uploadPath + fileName);
					}
					
					info.setSuccess(true);
					info.setMsg("上传成功！");
	
				} catch (IOException e) {
					e.printStackTrace();
					log.info("系统异常");
					info.setSuccess(false);
					info.setMsg("系统异常！");
				}
			}
		}else{
			info.setSuccess(true);
			info.setMsg("发布成功！");
		}
		
		if(info.getSuccess()){
			articleService.saveArticle(article);
		}
		
		return info;
	}
	
	/**
	 * 
	 * @param bid
	 * @param imgOrVideo
	 * @param isThumb	是否缩略图
	 * @param response
	 */
	@RequestMapping("/getblogimgorvideo")
	public void getBlogImgOrVideo(@RequestParam(value="bid") String bid,@RequestParam(value="imgorvideo") String imgOrVideo,@RequestParam(value="0") String isThumb,HttpServletResponse response){
    	log.info("jsonlogin");
    	log.info(bid);
    	
    	Long lbid = 0L;
    	try{
    		lbid = Long.parseLong(bid);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	
    	Article a = this.articleService.getArticle(lbid);    	

    	String path = "c:\\headpic\\notfound.jpg";
    	if(a!=null && imgOrVideo!=null && imgOrVideo.equals("img") && a.getImg()!=null){
    		path = a.getImg();
    		
    		//缩略图
    		if(isThumb != null && isThumb.equals("1")){
    			String filePrex = path
						.substring(0, path.lastIndexOf('.'));
				path = filePrex + "_t"
						+ path.substring(filePrex.length());
    		}
    	}
    	if(a!=null && imgOrVideo!=null && imgOrVideo.equals("video") && a.getVideo()!=null)
    		path = a.getVideo();
    	
		try {
			File f = new File(path);
			log.info("path:" + path);
			if(!f.exists())
				return;
			
			InputStream is = new FileInputStream(new File(path));
			OutputStream out = response.getOutputStream(); 
	    	byte[] buffer = new byte[1024];
	    	int size = 0;
	    	while ((size = is.read(buffer)) != -1) {
	    	      out.write(buffer, 0, size);
	    	}
	    	out.flush(); 
	    	out.close();
	    	is.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
}
