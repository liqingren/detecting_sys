package com.rongxin.log.dao;

import com.rongxin.log.pojo.DetectLog;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DetectLogMapper extends MongoRepository<DetectLog,String> {
}
