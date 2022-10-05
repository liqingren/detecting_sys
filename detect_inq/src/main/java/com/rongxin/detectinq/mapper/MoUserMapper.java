package com.rongxin.detectinq.mapper;

import com.rongxin.detectinq.entity.vo.MoUser;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MoUserMapper extends MongoRepository<MoUser,String> {

//    /**
//     * 多表联查
//     * @return
//     */
//    Object findUserAndResult();
}
