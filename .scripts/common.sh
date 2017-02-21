
to_absolute()
{
    (cd "$1"; pwd)
}
round()
{
    awk  'BEGIN { rounded = sprintf("%.0f", '$1'); print rounded }'
};
dict_lookup()
{
    echo $(cat meta_q.txt | grep $2 | sed 's/'$2': *//')
};

img_width()
{
    identify $1 | awk '{print $3}' | awk 'BEGIN{FS="x"}{print $1}'
}

img_height()
{
    identify $1 | awk '{print $3}' | awk 'BEGIN{FS="x"}{print $2}'
}
