package com.bnu.card.repository.t;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.repository.Repository;

public interface NativeQueryRepository<T, ID extends Serializable> extends Repository<T,ID>{
	public List<T> queryNatively(String nativeQueryName, LinkedHashMap<String,Class<?>> inEntityClasses, Map inParams );
}
