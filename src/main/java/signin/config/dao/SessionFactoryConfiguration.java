package signin.config.dao;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;


@Configuration
public class SessionFactoryConfiguration {
    /**
     * Created by WuTaoyu on 2017/12/7.
     */

        @Autowired
        private DataSource dataSource;

        @Bean(name = "sqlSessionFactory")
        public SqlSessionFactoryBean sqlSessionFactoryBean() {
            SqlSessionFactoryBean sqlsession = new SqlSessionFactoryBean();
            sqlsession.setDataSource(dataSource);

            try {
                //添加XML目录
                ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
                sqlsession.setMapperLocations(resolver.getResources("classpath:signin/dao/*.xml"));

            } catch (Exception e) {
                e.printStackTrace();
            }
            return sqlsession;
        }

        @Bean
        public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
            return new SqlSessionTemplate(sqlSessionFactory);
        }

        @Bean
        public PlatformTransactionManager annotationDrivenTransactionManager() {
            return new DataSourceTransactionManager(dataSource);
        }


    }


