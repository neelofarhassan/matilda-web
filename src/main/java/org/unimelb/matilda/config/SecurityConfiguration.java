package org.unimelb.matilda.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.authentication.AuthenticationTrustResolverImpl;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
 
@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
 
    @Autowired
    @Qualifier("customUserDetailsService")
    UserDetailsService userDetailsService;
 
    @Autowired
    PersistentTokenRepository tokenRepository;
    
    @Autowired
    CustomSuccessHandler customSuccessHandler;
    
    @Autowired
    public void configureGlobalSecurity(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService);
        auth.authenticationProvider(authenticationProvider());
    }
 
    @Override
    protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable().
		authorizeRequests()
		.antMatchers("/", "/submit", "/data-analytics")
        .access("hasRole('USER') or hasRole('ADMIN') or hasRole('DBA')")
        .antMatchers("/list", "/newuserslist", "/approveuser-**")
        .access("hasRole('ADMIN')")
        .antMatchers("/delete-user-*").access("hasRole('ADMIN')").antMatchers("/edit-user-*")
        .access("hasRole('ADMIN') or hasRole('DBA')").and().formLogin().successHandler(customSuccessHandler)
        .loginPage("/login").loginProcessingUrl("/login")
        .usernameParameter("ssoId").passwordParameter("password").and()
        .rememberMe().rememberMeParameter("remember-me").tokenRepository(tokenRepository)
        .tokenValiditySeconds(86400).and().exceptionHandling().accessDeniedPage("/Access_Denied");
//        .and()
//        .requiresChannel().antMatchers("/login").requiresSecure()
//        .requiresChannel().antMatchers("/submit", "/data-analytics", "/list", "/newuserslist", "/approveuser", "/delete-user-*", "/login").requiresSecure();
//        .requiresChannel().anyRequest().requiresSecure();
  	

    }
 
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
 
    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setUserDetailsService(userDetailsService);
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        return authenticationProvider;
    }
 
    @Bean
    public PersistentTokenBasedRememberMeServices getPersistentTokenBasedRememberMeServices() {
        PersistentTokenBasedRememberMeServices tokenBasedservice = new PersistentTokenBasedRememberMeServices(
                "remember-me", userDetailsService, tokenRepository);
        return tokenBasedservice;
    }
 
    @Bean
    public AuthenticationTrustResolver getAuthenticationTrustResolver() {
        return new AuthenticationTrustResolverImpl();
    }
 
}