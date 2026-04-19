#ifndef LG_CONVERSATION_H
#define LG_CONVERSATION_H

#include "../Support/LGTypes.h"

typedef struct LGMessage {
    LGRole role;
    char *text;
    struct LGMessage *next;
} LGMessage;

typedef struct LGConversation {
    char *title;
    LGMessage *first_message;
    LGMessage *last_message;
} LGConversation;

LGConversation *LGConversationCreate(void);
void LGConversationDestroy(LGConversation *conversation);
int LGConversationAppendMessage(LGConversation *conversation, LGRole role, const char *text);

#endif

