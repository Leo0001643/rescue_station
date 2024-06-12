package com.platform.modules.chat.service;

import cn.hutool.json.JSONObject;

import java.util.List;

/**
 * <p>
 * 待办事项 服务层
 * q3z3
 * </p>
 */
public interface ChatWeatherService {

    /**
     * 预报天气
     */
    List<JSONObject> queryByCityName(String cityName);

}
