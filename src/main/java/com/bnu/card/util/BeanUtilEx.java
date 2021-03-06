package com.bnu.card.util;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DoubleConverter;
import org.apache.commons.beanutils.converters.LongConverter;
import org.apache.commons.beanutils.converters.SqlDateConverter;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public final class BeanUtilEx
    extends BeanUtils {

  private static Map cache = new HashMap();
  private static Log logger = LogFactory.getFactory().getInstance(BeanUtilEx.class);

  private BeanUtilEx() {
  }

  static { 
	    Long LONG_ZERO = new Long("0");  
	    Double DOUBLE_ZERO = new Double("0");
	    LongConverter bd = new LongConverter(LONG_ZERO);    
	    DoubleConverter dd = new DoubleConverter(DOUBLE_ZERO);    
	    ConvertUtils.register(bd, java.lang.Long.class);  
	    ConvertUtils.register(dd, java.lang.Double.class);   
	    
    //注册sql.date的转换器，即允许BeanUtils.copyProperties时的源目标的sql类型的值允许为空
    ConvertUtils.register(new DateConvert(), java.sql.Date.class);
    ConvertUtils.register(new DateConvert(), java.sql.Timestamp.class);
    //注册util.date的转换器，即允许BeanUtils.copyProperties时的源目标的util类型的值允许为空
    ConvertUtils.register(new DateConvert(), java.util.Date.class);
   
  }

  public static void copyProperties(Object target, Object source) throws
      InvocationTargetException, IllegalAccessException {

	  org.apache.commons.beanutils.BeanUtils.copyProperties(target, source);

  }
}
