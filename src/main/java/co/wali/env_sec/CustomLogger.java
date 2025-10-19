package co.wali.env_sec;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.context.ServletWebServerInitializedEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;


@Configuration
public class CustomLogger implements ApplicationListener<ServletWebServerInitializedEvent> {

    private static final Logger logger = LoggerFactory.getLogger(CustomLogger.class);

    @Override
    public void onApplicationEvent(@SuppressWarnings("null") ServletWebServerInitializedEvent event) {
        int port = event.getWebServer().getPort();
        String scheme = event.getWebServer().getClass().getSimpleName().contains("Https") ? "https" : "http";
        @SuppressWarnings("null")
        String contextPath = event.getApplicationContext().getServletContext().getContextPath();

        String url = scheme + "://localhost:" + port + contextPath;
        String displayText = "Started application at " + url;

        // ANSI hyperlink escape sequence: \u001B]8;;url\u0007text\u0007
        String hyperlink = "\u001B]8;;" + url + "\u0007" + displayText + "\u0007";       
        logger.info(hyperlink);
    }
}