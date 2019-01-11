package org.unimelb.matilda.config;

import java.io.IOException;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.format.FormatterRegistry;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.unimelb.matilda.converter.RoleToUserProfileConverter;

/**
 * @author Neelofar
 */

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = { "org.unimelb.matilda"})
public class WebConfig extends WebMvcConfigurerAdapter {

	 @Autowired
	    RoleToUserProfileConverter roleToUserProfileConverter;
	     
   @Bean
   public InternalResourceViewResolver resolver() {
      InternalResourceViewResolver resolver = new InternalResourceViewResolver();
      resolver.setViewClass(JstlView.class);
      resolver.setPrefix("/WEB-INF/views/");
      resolver.setSuffix(".jsp");
      return resolver;
   }

   @Bean(name="multipartResolver") 
   public CommonsMultipartResolver getResolver() throws IOException{
       CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        
       //Set the maximum allowed size (in bytes) for each individual file.
       resolver.setMaxUploadSizePerFile(5242880);//5MB
       return resolver;
   }
   
   @Bean
   public MessageSource messageSource() {
      ResourceBundleMessageSource source = new ResourceBundleMessageSource();
      source.setBasename("messages");
      return source;
   }
   
   @Bean
   public JavaMailSender getMailSender(){
       JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        
       //Using gmail
       mailSender.setHost("smtp.gmail.com");
       mailSender.setPort(587);
       mailSender.setUsername("matilda.unimelb@gmail.com");
       mailSender.setPassword("Matilda123");
        
       Properties javaMailProperties = new Properties();
       javaMailProperties.put("mail.smtp.starttls.enable", "true");
       javaMailProperties.put("mail.smtp.auth", "true");
       javaMailProperties.put("mail.transport.protocol", "smtp");
       javaMailProperties.put("mail.debug", "true");//Prints out everything on screen
       javaMailProperties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
       mailSender.setJavaMailProperties(javaMailProperties);
       return mailSender;
   }

   @Override
   public Validator getValidator() {
      LocalValidatorFactoryBean validator = new LocalValidatorFactoryBean();
      validator.setValidationMessageSource(messageSource());
      return validator;
   }
   
   @Override
   public void addResourceHandlers(final ResourceHandlerRegistry registry) {
       registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
       registry.addResourceHandler("/usersdata/**").addResourceLocations("file:/servers/matilda-users/");
   }

   // equivalent for <mvc:default-servlet-handler/> tag
   @Override
   public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
       configurer.enable();
   }
   
   /**
    * Configure Converter to be used.
    * In our example, we need a converter to convert string values[Roles] to UserProfiles in newUser.jsp
    */
   @Override
   public void addFormatters(FormatterRegistry registry) {
       registry.addConverter(roleToUserProfileConverter);
   }
    
   /**Optional. It's only required when handling '.' in @PathVariables which otherwise ignore everything after last '.' in @PathVaidables argument.
    * It's a known bug in Spring [https://jira.spring.io/browse/SPR-6164], still present in Spring 4.1.7.
    * This is a workaround for this issue.
    */
   @Override
   public void configurePathMatch(PathMatchConfigurer matcher) {
       matcher.setUseRegisteredSuffixPatternMatch(true);
   }
}
