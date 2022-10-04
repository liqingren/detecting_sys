package com.rongxin.detectinq.mapper.mongo;

import com.rongxin.detectinq.entity.vo.MoResult;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MoResultMapper extends MongoRepository<MoResult,String> {
}
