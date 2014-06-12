package com.bnu.card.repository.t;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface NativeQuery {
String name()  default "";
String sql()  default "";
}