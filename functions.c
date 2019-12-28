#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int isalpha(char x) {
    return ((x >= 'a' && x <= 'z') || (x >= 'A' && x <= 'Z'));
}
int isNum(char x) {
    return (x >= '0' && x <= '9');
}

int isInteger(char *val) {
    int i;
    for (i = 0; i < strlen(val); i++) {
        if (isNum(val[i]) == 0)
            return 0;
    }
    return 1;
}
int isDouble(char *val) {
    int i;
    int f = 0;
    for (i = 0; i < strlen(val); i++) {
        if (isNum(val[i]) == 0) {
            if (val[i] == '.') {
                if (f) {
                    return 0;
                }
                f = 1;
            } else {
                return 0;
            }
        }
    }
    if (f)
        return 1;
    else
        return 0;
}

struct identifier {
    int type;
    char *varname;
    char *strval;
    int intval;
    double doubleval;
};
struct identifier constructor(int typex, char *varnamex, char *valx) {
    struct identifier data;
    data.type = typex;
    data.varname = (char *) malloc((strlen(varnamex)+1)*sizeof(char));
    strcpy((data).varname,varnamex);
    if (typex == 1) {
        (data).intval = atoi(valx);
    } else if (typex == 2) {
        (data).doubleval = atof(valx);
    } else if (typex == 3) {
        (data).strval = (char *)malloc((strlen(valx) + 1) * sizeof(char));
        strcpy((data).strval,valx);
    }
    return data;
}
void print(struct identifier data) {
    if((data).type==1) {
        printf("%d\n",(data).intval);
    } else if((data).type==2) {
        printf("%f\n",(data).doubleval);
    } else if((data).type==3) {
        printf("%s\n",(data).strval);
    } else {
        printf("none\n");
    }
}

struct ll_identifier {
    struct identifier data;
    struct ll_identifier *next;
};
void push_back_ll(struct ll_identifier** root,struct ll_identifier** last,struct identifier newdata) {
    struct ll_identifier* new_node =(struct ll_identifier*) malloc(sizeof(struct ll_identifier));
    new_node->data=newdata;
    new_node->next=NULL;
    if(*root==NULL) {
        *root = new_node;
    } else {
        (*last)->next = new_node;
    }
    *(last)=new_node;
    return;
}
struct ll_identifier* isDeclared(struct ll_identifier** root,char *varname) {
    struct ll_identifier *now=*root,*ans=NULL;
    while (now!=NULL) {
        if(strcmp(now->data.varname,varname)==0) {
            ans=now;
            break;
        }
        now=now->next;
    }
    return ans;
}
int addNewVal(struct ll_identifier **root,struct ll_identifier **last,char *str,char *val) {
    if(isDeclared(root,str)!=NULL)
        return 0;
    int type = 4;
    if(isInteger(val))
        type=1;
    else if(isDouble(val))
        type=2;
    else if(strlen(val)>0)
        type=3;
    struct identifier tmp=constructor(type,str,val);
    push_back_ll(root,last,tmp);
    return 1;
}

struct ll_identifier *getVal(struct ll_identifier **root,char *str) {
    return isDeclared(root,str);
}
void setVal(struct ll_identifier **root,struct ll_identifier **last, char *str, char *val) {
    struct ll_identifier* idx = isDeclared(root,str);
    if(idx==NULL) {
        addNewVal(root,last,str,val);
    } else {
        int type = 4;
        if(isInteger(val))
            type=1;
        else if (isDouble(val))
            type = 2;
        else if (strlen(val) > 0)
            type = 3;
        idx->data=constructor(type,str,val);
    }
}
void print_all(struct ll_identifier *now) {
    if(now==NULL)
        return;
    print(now->data);
    print_all(now->next);
}
// int main() {
//     struct ll_identifier *root,*last;
//     root=last=NULL;
//     char varname[100],value[100];
//     int type;

//     for(int i=0; i<4; i++) {
//         scanf("%s%s",&varname,&value);
//         // getchar();
//         addNewVal(&root,&last,varname,value);
//         print(last->data);
//     }
//     print_all(root);
//     while(1) {
//         scanf("%s",&varname);
//         struct ll_identifier* res=getVal(&root,varname);
//         if(res!=NULL) {
//             print(res->data);
//         }
//     }
// }
