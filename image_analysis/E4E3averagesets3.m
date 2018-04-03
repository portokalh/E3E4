%see connectivity
%14 apoe4
%10 apoe3
%10 y c57
%10 o C57
close all
mycolormap = jet(101);
mypathin='/Users/alex/Documents/MATLAB/E3E4_scripts/'
[mylegends,myabbrev]=xlsread('/Users/alex/Documents/MATLAB/alex/APOE34/CHASSSYMMETRIC2Legends09072017.xlsx', 'thetruth', 'B2:B333');
[myvertices,mytop]=xlsread('/Users/alex/Documents/MATLAB/alex/APOE34/vertex_wang.xlsx','B2:B333');
%mycolormap(1,:)=[1 1 1]

runnos={'N54717' 'N54718' 'N54719' 'N54720' 'N54722'  'N54759' 'N54760' 'N54761' 'N54762' 'N54763'  'N54764' 'N54765' 'N54766' 'N54770' 'N54771' 'N54772' 'N54798' 'N54801' 'N54802' 'N54803' 'N54804' 'N54805' 'N54806' 'N54807' 'N54818' 'N54824' 'N54825' 'N54826' 'N54837' 'N54838' 'N54843' 'N54844' 'N54856' 'N54857' 'N54858' 'N54859' 'N54860' 'N54861' 'N54873' 'N54874' 'N54875' 'N54876' 'N54877' 'N54879' 'N54880' 'N54891' 'N54892' 'N54893' 'N54897' 'N54898' 'N54899' 'N54900' 'N54915' 'N54916' 'N54917'};
groups=[4 4 4 4 4 2 2 4 4 4 4 2 4 4 3  3 3 3 3 3 3 3 3 3 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 4 4 4]
mypath='/Volumes/CivmUsers/omega/alex/E3E4v1/connect4dsistudio/pre_rigid_native_space/connectivitymats/pics/'
mypath='/Users/alex/Documents/MATLAB/alex/APOE34/connectivitymats/';
ind1=find(groups==1);
ind2=find(groups==2);
ind3=find(groups==3);
ind4=find(groups==4);

%for n =1:55
figure1=figure('Name', 'Whole Brain 332');

mymat3=zeros(332,332);
for n3=1:numel(ind3)
    
        
    runno=runnos{ind3(n3)} ;
    %'E3'; groups(ind3(n));
    
    fprintf('%s : %d\n' ,runno, groups(ind3(n3)))
    
   
     myconn=[mypath runno '/' runno 'con.mat'];
     res=load(myconn);
     mymat3=mymat3+100*res.connectivity./sum(sum(res.connectivity));
%     find(mymat);
     
%     imagesc(log10(mymat))
%     caxis([0 5])
%     %max(max(log10(mymat)))
%     title(runno)
%     colormap(jet)
%     filename = strcat(mypath, runno, '_conmat.png');
%     print(filename,'-dpng','-r300');
%     
end  

mymat3=mymat3/n3;
mymat3_1=mymat3;
figure1;title('Whole Brain')
sax1=subplot(1,3,1);imagesc((100*mymat3)); title ('E3'); colorbar
mycolormap = jet(101);
%mycolormap(1,:)=[1 1 1]
caxis(sax1,[0 1])
colormap(sax1,mycolormap)

mymat4=zeros(332,332);

for n4=1:numel(ind4)
    
        
    runno=runnos{ind4(n4)} ;
    
    % 'E4'; groups(ind4(n));
    fprintf('%s : %d\n' ,runno, groups(ind4(n4)))
    
   
     myconn=[mypath runno '/' runno 'con.mat'];
     res=load(myconn);
     mymat4=mymat4+100*res.connectivity./sum(sum(res.connectivity));
%     find(mymat);
     
%     imagesc(log10(mymat))
%     caxis([0 5])
%     %max(max(log10(mymat)))
%     title(runno)
%     colormap(jet)
%     filename = strcat(mypath, runno, '_conmat.png');
%     print(filename,'-dpng','-r300');
%     
end  
mymat4=mymat4/n4;
mymat4_1=mymat4;

figure1; sax2=subplot(1,3,2);imagesc((100*mymat4));  title ('E4'); colorbar
mycolormap = jet(101);
%mycolormap(1,:)=[1 1 1]
caxis(sax2,[0 1])
colormap(sax2,mycolormap)


figure1; sax3=subplot(1,3,3);imagesc(log10(mymat3./mymat4));  title ('E3-E4'); colorbar
mycolormap = jet(101);
mycolormap(51,:)=[1 1 1]
colormap(mycolormap)
colorbar
caxis(sax3,[-2 2])
colormap(sax3,mycolormap)



filename = strcat(mypath, 'fullset_conmat.png'); print(filename,'-dpng','-r300');
print(filename,'-dpng','-r300');

figure2=figure('Name','Whole Brain Ordered 296')
subset296=[1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
149
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
60
151
166
62
63
64
65
66
67
68
59
61
69
70
71
72
73
74
75
76
77
78
79
80
154
155
156
157
158
163
164
165
81
82
83
84
85
86
87
88
159
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
153
160
162
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
150
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
315
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
226
317
332
228
229
230
231
232
233
234
225
227
235
236
237
238
239
240
241
242
243
244
245
246
320
321
322
323
324
329
330
331
247
248
249
250
251
252
253
254
325
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
319
326
328
284
285
286
287
288
289
290
291
292
293
294
295
296
297
298
299
300
301
302
303
304
305
306
307
308
309
310
311
312
313
316];

mymat3=mymat3_1(subset296,subset296)
mymat4=mymat4_1(subset296,subset296)

figure2; sax1=subplot(1,3,1);imagesc((mymat3));  title ('E3'); colorbar
mycolormap = jet(101);
%mycolormap(1,:)=[1 1 1]
colormap(mycolormap)
colorbar
caxis(sax1,[0 5])
colormap(sax1,mycolormap)
colorbar;

figure2; sax2=subplot(1,3,2);imagesc((mymat4));  title ('E4'); colorbar
mycolormap = jet(101);
%mycolormap(1,:)=[1 1 1]
colormap(mycolormap)
colorbar
caxis(sax2,[0 5])
colormap(sax2,mycolormap)
colorbar;



figure2; sax3=subplot(1,3,3);imagesc((mymat3./mymat4));  title ('E3-E4'); colorbar
mycolormap = jet(101);
mycolormap(51,:)=[1 1 1]
colormap(mycolormap)
colorbar
caxis(sax3,[-2 2])
colormap(sax3,mycolormap)
colorbar;


filename = strcat(mypath, 'set296_conmat.png'); print(filename,'-dpng','-r300');
print(filename,'-dpng','-r300');

subset=[101
41
15
265
208
46
98
66
57
241
220
17
82
91
218
90
68
264
223
21
244
102
202
180
239
92
221
51
232
267
93
306
54
42
14
268
207
217
242
140
257
233
20
256
219
282
280
67
118
293
145
272
210
292
302
111
76
286
112
121
151
99
289
163
97
81
43
187
259
149
310
107
31
108
245
279
88
80
62
253
9
258
164
248
45
296
53
255
30
304
103
251
106
116
128
95
325
203
278
89
134
133
85
250
119
105
320
153
181
155
247
230
7
48
195
240
58
270
110
59
77
86
157
28
263
238
2
298
308
168
274
152
78
204
136
79
311
84
19
277
200
143
10
273
243
104
83
235
260
284
75
294
72
300
12
73
323
276
330
120
69
261
139
166
22
299
144
165
64
216
317
8
61
236
231
225
332
127
125
94
209
1
123
329
135
287
234
309
87
71
319
142
199
113
74
130
148
158
321
285
34
160
154
33
229
11
38
60
322
314
156
35
301
183
5
109
55
115
147
129
175
174
249
313
315
122
318
177
36
24
254
288
96
295
271
146
37
184
246
324
281
16
191
29
198
126
262
214
215
316
65
13
182
124
171
27
141
328
162
252
63
190
50
266
186
44
114
161
159
185
170
194
326
52
327
173
237
100
275
70
150
132
138
307
169
222
297
303
228
131
167
305
32
56
331
269
290
196
176
3
201
117
49
39
206
192
18
227
226
197
6
193
188
47
283
40
224
312
25
23
213
137
291
205
189
211
172
178
179
26
212
4];

mysubset=sort(subset(1:50));
mymat3=mymat3_1(mysubset,mysubset)
mymat4=mymat4_1(mysubset,mysubset)

figure3=figure('Name', 'Top 50 Vertices'); sax1=subplot(1,3,1);imagesc((mymat3));  title ('E3'); colorbar
mycolormap = jet(101);
%mycolormap(1,:)=[1 1 1]
colormap(mycolormap)
colorbar
caxis(sax1,[1 4])
colormap(sax1,mycolormap)
colorbar;

figure3; sax2=subplot(1,3,2);imagesc((mymat4));  title ('E4'); colorbar
mycolormap = jet(101);
%mycolormap(1,:)=[1 1 1]
colormap(mycolormap)
colorbar
caxis(sax2,[1 4])
colormap(sax2,mycolormap)
colorbar;



figure3; sax3=subplot(1,3,3);imagesc((mymat3./mymat4));  title ('E3-E4'); colorbar
mycolormap = jet(101);
mycolormap(51,:)=[1 1 1]
colormap(mycolormap)
colorbar
caxis(sax3,[-1 1])
colormap(sax3,mycolormap)
colorbar;


filename = strcat(mypath, 'subset50_conmat.png'); print(filename,'-dpng','-r300');
print(filename,'-dpng','-r300');



%add left and right in one figure

mysubset=sort(subset(1:30))
mysubsetL=mysubset(find(mysubset <= 166))
mysubsetLL=mysubsetL+166

mysubsetR=mysubset(find(mysubset >= 167))
mysubsetRR=mysubsetR-166

mysubset=unique(sort([mysubsetL' mysubsetLL' mysubsetR' mysubsetRR']))

mymat3=mymat3_1(mysubset,mysubset)
mymat4=mymat4_1(mysubset,mysubset)

figure4=figure('Name','BothHemisphereVertices'); sax1=subplot(1,3,1);imagesc(100*(mymat3));  title ('E3'); colorbar
mycolormap = jet(101);
%mycolormap(1,:)=[1 1 1]
colormap(mycolormap)
colorbar
caxis(sax1,[0 1])
colormap(sax1,mycolormap)
colorbar;
h4=gca(figure4)
h4.XTick=1:numel(mysubset);
h4.YTick=1:numel(mysubset);
h4.XTickLabel=myabbrev(mysubset)
h4.YTickLabel=myabbrev(mysubset)
h4.XTickLabelRotation=90
set(h4, 'FontSize', 20, 'LineWidth', 2);

figure4; sax2=subplot(1,3,2);imagesc(100*(mymat4));  title ('E4'); colorbar
mycolormap = jet(101);
%mycolormap(1,:)=[1 1 1]
colormap(mycolormap)
colorbar
caxis(sax2,[0 1])
colormap(sax2,mycolormap)
colorbar;
h4=gca(figure4)
h4.XTick=1:numel(mysubset);
h4.YTick=1:numel(mysubset);
h4.XTickLabel=myabbrev(mysubset)
h4.YTickLabel=myabbrev(mysubset)
h4.XTickLabelRotation=90
set(h4, 'FontSize', 20, 'LineWidth', 2);


res=100*(mymat4-mymat3)./mymat3
figure4; sax3=subplot(1,3,3);imagesc(res);  title ('Reduced Connectivity in E4 vs E3'); colorbar
mycolormap = winter(101);
mycolormap(101,:)=[1 1 1]

colormap(mycolormap)
colorbar
caxis(sax3,[-100 0])
colormap(sax3,mycolormap)
colorbar;
h4=gca(figure4)         
h4.XTick=1:numel(mysubset);
h4.YTick=1:numel(mysubset);
h4.XTickLabel=myabbrev(mysubset)
h4.YTickLabel=myabbrev(mysubset)
h4.XTickLabelRotation=90
set(h4, 'FontSize', 20, 'LineWidth', 2);

res=100*(mymat4-mymat3)./mymat3
figure4; sax3=subplot(1,3,3);imagesc(res);  title ('Increased Connectivity in E4 vs E3'); colorbar
mycolormap = spring(101);
mycolormap(1,:)=[1 1 1]

colormap(mycolormap)
colorbar
caxis(sax3,[0 100])
colormap(sax3,mycolormap)
colorbar;
h4=gca(figure4)
h4.XTick=1:numel(mysubset);
h4.YTick=1:numel(mysubset); 
        
filename = strcat(mypath, 'subset30All_conmat.png'); print(filename,'-dpng','-r300');
print(filename,'-dpng','-r300');



