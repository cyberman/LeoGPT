#include "LGSettings.h"
#include <stdlib.h>

LGSettings *LGSettingsCreate(void)
{
    LGSettings *settings;

    settings = (LGSettings *)calloc(1, sizeof(LGSettings));
    if (settings == NULL) {
        return NULL;
    }

    settings->auto_save_chats = 1;
    return settings;
}

void LGSettingsDestroy(LGSettings *settings)
{
    if (settings == NULL) {
        return;
    }

    free(settings->endpoint_url);
    free(settings->default_model);
    free(settings);
}

