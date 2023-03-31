from superset.superset_typing import CacheConfig
from typing import Optional

#ENABLE_TIME_ROTATE = True
#VERSIONED_EXPORT = True
CACHE_DEFAULT_TIMEOUT = 86400
SUPERSET_WEBSERVER_TIMEOUT = 7200
CACHE_CONFIG: CacheConfig = {
    'CACHE_TYPE': 'RedisCache',
    'CACHE_DEFAULT_TIMEOUT':84600,
    'CACHE_KEY_PREFIX': 'superset_cache_',
    'CACHE_REDIS_URL': 'redis://redis:6379/2'
}
DATA_CACHE_CONFIG: CacheConfig = {
    'CACHE_TYPE': 'RedisCache',
    'CACHE_DEFAULT_TIMEOUT': 84600,
    'CACHE_KEY_PREFIX': 'superset_data_',
    'CACHE_REDIS_URL': 'redis://redis:6379/3'
}
FILTER_STATE_CACHE_CONFIG: CacheConfig = {
    'CACHE_TYPE': 'RedisCache',
    'CACHE_DEFAULT_TIMEOUT': 84600,
    'CACHE_KEY_PREFIX': 'superset_filter_',
    'CACHE_REDIS_URL': 'redis://redis:6379/4'
}
EXPLORE_FORM_DATA_CACHE_CONFIG: CacheConfig = {
    'CACHE_TYPE': 'RedisCache',
    'CACHE_DEFAULT_TIMEOUT': 84600,
    'CACHE_KEY_PREFIX': 'superset_explore_',
    'CACHE_REDIS_URL': 'redis://redis:6379/5'
}

SQLALCHEMY_DATABASE_URI = 'mysql://user:password@db:3306/superset'

GUEST_ROLE_NAME: "Public"

PUBLIC_ROLE_LIKE = "Gamma"

FEATURE_FLAGS = {
    'EMBEDDED_SUPERSET': True
}
