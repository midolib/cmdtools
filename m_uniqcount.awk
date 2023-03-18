#!/usr/bin/awk -f
BEGIN{OFS=FS;d_index=0;}{
	if(!d[$0]){
		d_keys[d_index++]=$0
	}
	d[$0]++;
}
END{
	for(i=0;i<d_index;i++){
		print(d_keys[i],d[d_keys[i]])
	}
}
