package com.bnu.card.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;

import com.bnu.card.web.form.TeacherAgeReportForm;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.reader.ReaderBuilder;
import net.sf.jxls.reader.XLSReader;
import net.sf.jxls.transformer.XLSTransformer;

/**
 * Excel生成类.
 */
public class ExcelUtil {
	/**
	 * 根据模板生成Excel文件.
	 * 
	 * @param templateFileName
	 *            模板文件.
	 * @param list
	 *            模板中存放的数据.
	 * @param resultFileName
	 *            生成的文件.
	 */
	public void createExcel(String templateFileName, List<?> list,
			String resultFileName) {
		// 创建XLSTransformer对象
		XLSTransformer transformer = new XLSTransformer();
		// 获取java项目编译后根路径
		// URL url = this.getClass().getClassLoader().getResource("");
		// //得到模板文件路径
		// String srcFilePath = url.getPath() + templateFileName;
		// String destFilePath = url.getPath() + resultFileName;
		String srcFilePath = templateFileName;
		String destFilePath = resultFileName;
		Map<String, Object> beanParams = new HashMap<String, Object>();
		beanParams.put("list", list);

		try {
			// 生成Excel文件
			transformer.transformXLS(srcFilePath, beanParams, destFilePath);
		} catch (ParsePropertyException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		}
	}
	
	public void createExcel(String templateFileName, Map<String,List<?>> m,
			String resultFileName) {
		// 创建XLSTransformer对象
		XLSTransformer transformer = new XLSTransformer();
		// 获取java项目编译后根路径
		// URL url = this.getClass().getClassLoader().getResource("");
		// //得到模板文件路径
		// String srcFilePath = url.getPath() + templateFileName;
		// String destFilePath = url.getPath() + resultFileName;
		String srcFilePath = templateFileName;
		String destFilePath = resultFileName;
//		Map<String, Object> beanParams = new HashMap<String, Object>();
//		beanParams.put("list", list);

		try {
			// 生成Excel文件
			transformer.transformXLS(srcFilePath, m, destFilePath);
		} catch (ParsePropertyException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		}
	}
	
	public void t(){
//		getTeacherAgeReportFormList(v, pas.getContent());
		List<String> l = new ArrayList<String>();
		l.add("sum");
		l.add("sum2");
		l.add("sum3");
		
		List<String> l2 = new ArrayList<String>();
		l2.add("sum");
		l2.add("sumM1");
		l2.add("sumF2");

		l2.add("sum2");
		l2.add("sum2M1");
		l2.add("sum2F2");
		
		l2.add("sum3");
		l2.add("sum3M1");
		l2.add("sum3F2");
		
		
		List<TeacherAgeReportForm> l3 = new ArrayList<TeacherAgeReportForm>();
		TeacherAgeReportForm tf = new TeacherAgeReportForm();
		tf.setGroupName("x");
		l3.add(tf);
		l3.add(tf);
		l3.add(tf);
		l3.add(tf);
		
		List<String> l4 = new ArrayList<String>();
		l4.add("2");
		l4.add("2");
		l4.add("2");

		l4.add("1");
		l4.add("1");
		l4.add("1");
		
		l4.add("3");
		l4.add("3");
		l4.add("3");
		tf.setGroupValue(l4);
		
		HashMap<String,List<?>> m = new HashMap<String,List<?>>();
		m.put("caption1", l);
		m.put("caption2", l2);
		m.put("content", l3);
		
		Calendar c = Calendar.getInstance();
		String fileName ="stu_nation_out" + c.getTimeInMillis();
		String outFilePath = "d:/test/" + fileName + ".xls";
		
//		XLSTransformer transformer = new XLSTransformer();
		
		createExcel("d:/test/teacher_age.xls", m, outFilePath);
	}

	public static void main(String[] args) {
//		List<Fruit> list = new ArrayList<Fruit>();
//		list.add(new Fruit("苹果", 2.01f));
//		list.add(new Fruit("桔子", 2.05f));
//		String templateFileName = "d:/test/template.xls";
//		String resultFileName = "d:/test/fruit.xls";
//		new ExcelUtil().createExcel(templateFileName, list, resultFileName);
//
//		List<Fruit> l = new ExcelUtil().findXls(resultFileName);
//		for (Fruit f : l) {
//			System.out.println(f.getName() + ":" + f.getPrice());
//		}
		new ExcelUtil().t();
	}

	public List<Fruit> findXls(String path) {
		// path 要读的Excel的路径
//		String xmlConfig = "d:/test/Fruit.xml"; // xml文件名
//		try {
//			// 构建xml文件输入流
//			// InputStream inputXML = new BufferedInputStream(this.getClass()
//			// .getResourceAsStream(xmlConfig));
////			InputStream inputXML = new BufferedInputStream(new FileInputStream(
////					new File(xmlConfig)));
//			// 绑定xml文件
////			XLSReader mainReader = ReaderBuilder.buildFromXML(inputXML);
////			// 构建文件输入流
////			InputStream inputXLS = new FileInputStream(path);
////			// 通过低级流构建，高级流
////			BufferedInputStream bis = new BufferedInputStream(inputXLS);
//			Fruit fruit = new Fruit();
//			List<Fruit> fruits = new ArrayList<Fruit>();
//			Map beans = new HashMap();
//			beans.put("fruit", fruit);
//			beans.put("fruits", fruits);
//			// 通过XSLReader 的read方法，它会自动映射pojo类，得到数据集合
//			mainReader.read(bis, beans);
//			return fruits;
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		}
//		return null;
		String xmlConfig = "d:/test/Fruit.xml"; // xml文件名
		
		Fruit fruit = new Fruit();
		List<Fruit> fruits = new ArrayList<Fruit>();
		Map beans = new HashMap();
		beans.put("fruit", fruit);
		beans.put("fruits", fruits);
		
		xls2Beans(xmlConfig,"d:/test/fruit.xls",beans);
		
		return fruits;
	}

	public void xls2Beans(String xmlPath,String xls,Map beanMap) {
		// path 要读的Excel的路径
//		String xmlConfig = "d:/test/Fruit.xml"; // xml文件名
		try {
			// 构建xml文件输入流
			// InputStream inputXML = new BufferedInputStream(this.getClass()
			// .getResourceAsStream(xmlConfig));
			InputStream inputXML = new BufferedInputStream(new FileInputStream(
					new File(xmlPath)));
			// 绑定xml文件
			XLSReader mainReader = ReaderBuilder.buildFromXML(inputXML);
			// 构建文件输入流
			InputStream inputXLS = new FileInputStream(xls);
			// 通过低级流构建，高级流
			BufferedInputStream bis = new BufferedInputStream(inputXLS);
			// 通过XSLReader 的read方法，它会自动映射pojo类，得到数据集合
			mainReader.read(bis, beanMap);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
