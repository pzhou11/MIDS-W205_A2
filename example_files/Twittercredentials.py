import tweepy

consumer_key = "NMuXMt7RMY0VV3dCkTVUocUmo";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "QKAVcsiKAAh3RwqMDpQQ9FuIOT38Tls26UWF8t9yra3P2ummjo";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "2345464736-xQKYo2LUBC0LuwDDTpExotZ05eQb3HrvF8Bx0FL";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "doP0LjNHwb9K4Pmf4UQs2neZfiooVL5NuV1muxUboxI2N";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



