#ifndef LG_SETTINGS_H
#define LG_SETTINGS_H

typedef struct LGSettings {
    char *endpoint_url;
    char *default_model;
    int auto_save_chats;
} LGSettings;

LGSettings *LGSettingsCreate(void);
void LGSettingsDestroy(LGSettings *settings);

#endif

