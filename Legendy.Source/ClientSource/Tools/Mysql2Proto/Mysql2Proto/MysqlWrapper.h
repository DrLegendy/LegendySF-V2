#ifndef __MYSQL_WRAPPER_H__
#define __MYSQL_WRAPPER_H__

#include <cstdio>
// #include "my_global.h"
#include "mysql.h"
#include "Singleton.h"

class MysqlResSP
{
	private:
		MYSQL_RES * m_res;
	public:
		MYSQL_RES * & Get()
		{
			return m_res;
		}
		void Destroy()
		{
			if (m_res)
				mysql_free_result(m_res);
		}
		MysqlResSP(MYSQL_RES * res) : m_res(res)
		{
		}
		~MysqlResSP()
		{
			Destroy();
		}
};

class MysqlWrapper : public CSingleton<MysqlWrapper>
{
	private:
		MYSQL * m_con;

	public:
		MysqlWrapper() : m_con(NULL)
		{
			m_con = mysql_init(NULL);

			if (!m_con)
			{
				fprintf(stderr, "Error: %s\n", mysql_error(m_con));
				exit(0);
			}
		}

		~MysqlWrapper()
		{
			if (m_con)
			{
				mysql_close(m_con);
			}
		}

		MYSQL * & GetMysql()
		{
			return m_con;
		}

		int CountRows(MYSQL_RES * res = NULL)
		{
			return (res) ? mysql_num_rows(res) : 0;
		}

		int CountFields(MYSQL_RES * res = NULL)
		{
			return (res) ? mysql_num_fields(res) : 0;
		}

		MYSQL_ROW FetchRow(MYSQL_RES * res = NULL)
		{
			return (res) ? mysql_fetch_row(res) : NULL;
		}

		bool Connect(const char* hostname, const char* user, const char* password, const char* database = NULL, unsigned int port = 0)
		{
			if (!mysql_real_connect(m_con, hostname, user, password, database, port, NULL, 0))
			{
				fprintf(stderr, "Error: %s\n", mysql_error(m_con));
				// mysql_close(m_con);
				exit(0);
				return false;
			}
			return true;
		}

		bool DirectQuery(const char* query)
		{
			if (mysql_query(m_con, query))
			{
				fprintf(stderr, "Error: %s\n", mysql_error(m_con));
				// mysql_close(m_con);
				// exit(0);
				return false;
			}
			return true;
		}

		MYSQL_RES * ResultQuery(const char* query)
		{
			if (mysql_query(m_con, query))
			{
				fprintf(stderr, "Error: %s\n", mysql_error(m_con));
				// mysql_close(m_con);
				// exit(0);
				return NULL;
			}
			MYSQL_RES * result = mysql_store_result(m_con);
			if (!result)
			{
				fprintf(stderr, "Error: %s\n", mysql_error(m_con));
				// mysql_close(m_con);
				// exit(0);
				return NULL;
			}
			return result; // must be freed or you get memory leaked (mysql_free_result)
		}

		void PrintVersion()
		{
			printf("MySQL client version: %s\n", mysql_get_client_info());
		}

};

#endif

