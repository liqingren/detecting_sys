package com.rongxin.detectinq.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.concurrent.ConcurrentHashMap;

@Setter
@Getter
// ServerEndpointExporter bean扫描ServerEndpoint,这个注解和我们之前用的requestMapping相似
@ServerEndpoint("/{uuid}")
@Component
public class WebSocketServer {
    private Session session;
    public static ConcurrentHashMap<String,WebSocketServer> clients = new ConcurrentHashMap<>();
    /**
     *  onOpen 当客户端和服务端建立连接的时候会触发 onOpen方法
     *  onClose: 当客户端和服务端断开连接的时候会触发onClose 方法
     *  onError: 当客户端和服务端建立连接的时候出了问题会触发
     *  onMessage: 当客户端服务器发送数据的时候会被触发
     */
    @OnOpen
    public void onOpen(Session session, @PathParam( "uuid") String uuid){
        System.out.println("客户端连接===>"+uuid);
        this.session = session;
        clients.put(uuid,this);
    }
    @OnClose
    public void onClose(@PathParam( "uuid") String uuid){
        clients.remove(uuid);
    }
    @OnError
    public void onError(Throwable error) {
        error.printStackTrace();
    }

    @OnMessage
    public void onMessage(String msg){
        System.out.println(msg);
    }
}

