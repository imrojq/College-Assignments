function hw3part4

load('mnist.mat');

tridx = [];
validx = [];
tsidx = [];

% fraction of the data to be used for validation and test.
valfrac = 0.2;
tsfrac = 0.2;

for k = 1:size(label,2)
    % ifnd the indices of the data points of a particular class
    r = find(label(:,k) == 1);
    % number of data points belonging tot eh k^th class
    nclass = length(r);
    % randomize the indices for the k^{th} class data points
    ridx = randperm(nclass);
    % use the first nclass*tsfrac indices as the test data points
    temptsidx = r(ridx(1:nclass*tsfrac));
    % use the next nclass*valfrac indices as the validation set
    tempvalidx = r(ridx(nclass*tsfrac+1:nclass*tsfrac+1+nclass*valfrac));
    % use the remaining indices as training points
    temptridx = setdiff(r, [temptsidx; tempvalidx]);    
    % append the indices to the cumulative variable
    tridx = [tridx temptridx];
    tsidx = [tsidx temptsidx];
    validx = [validx tempvalidx];
end

% separate the train, validation and test datasets
trX = data(tridx,:);
trY = label(tridx,:);

valX = data(validx,:);
valY = label(validx,:);

tsX = data(tsidx,:);
tsY = label(tsidx,:);


% size of the training data
[N, D] = size(trX);
% number of epochs
nEpochs = 100;
% learning rate
eta = 0.01;
% number of hidden layer units
H = 500;
% number of output layer units
K = 10;

% randomize the weights from input to hidden layer units
% 'TO DO'
w = -0.3+(0.6)*rand(H,(D+1));
% randomize the weights from hidden to output layer units
% 'TO DO'
v = -0.3+(0.6)*rand(K,(H+1));

% let us create the indices for the batches as it cleans up script later
% size of the training batches
batchsize = 25;
% number of batches
nBatches = floor(N/batchsize);
% create the indices of the data points used for each batch
% i^th row in batchindices will give th eindices for the data points for
% the i^th batch
batchindices = reshape([1:batchsize*nBatches]',batchsize, nBatches);
batchindices = batchindices';
% if there are any data points left out, add them at the end padding with
% some other indices from the previous batch
if N - batchsize*nBatches >0
    batchindices(end+1,:)=batchindices(end,:);
    batchindices(end,1:(N - batchsize*nBatches)) = [batchsize*nBatches+1: N];
end

% randomize the order of the training data
ridx = randperm(N);
trX = trX(ridx,:);
trY= trY(ridx,:);

size(batchindices);


for epoch = 1:nEpochs
    for batch = 1:nBatches
        % Call the forward pass function to obtain the outputs
        % 'TO DO'
        batchX = trX(batchindices(batch,:),:);
        batchY = trY(batchindices(batch,:),:);
        
        [z ydash] = forwardpass(batchX, w, v);

        % Call the gradient function to obtain the required gradient
        % updates
        [deltaw deltav] = computegradient(batchX,batchY, w, v, z, ydash);
        % 'TO DO'
        % update the weights of the two sets of weights
        % 'TO DO' w = w + eta*deltaw and v = v + eta*deltav
        w = w - deltaw*eta;
        v = v - deltav*eta;
        % at the end of epoch compute the classification error on training
        % and validation dataset
        % 'TO DO'
    end
        epoch
        [temp trydash]  = forwardpass(trX,w,v);
        [temp valydash] = forwardpass(valX,w,v);
        trError = classerror(trY, predict(trydash));
        disp(sprintf('training error after epoch %d: %f\n',epoch,...
        trError));
        valError = classerror(valY, predict(valydash));
        disp(sprintf('training error after epoch %d: %f\n',epoch,...
        valError));
end

% compute the classification error on the test set
% 'TO DO'
[temp tsydash] = forwardpass(tsX,w,v);
tsError = classerror(tsY,predict(tsydash));
disp(sprintf('training error after epoch %d: %f\n',epoch,...
        tsError));

% plot atmost 2 misclassified examples for each digit using the displayData
% function
%displayData(tsX(1,:));
error = (sum(abs(tsY-predict(tsydash)), 2)>0);
WrongX = tsX(error,:);
WrongY = tsY(error,:);
indexes = [];
for i = 1 :10
    wrongI = WrongX(WrongY(:,i) == 1,:);
    indexes = [indexes ;wrongI(1:2,:)];
end
displayData(indexes);
        
    

function [y] = predict(ydash)
m = size(ydash,1);
y = zeros(size(ydash));
for i =1:m
    [dummy, index] = max(ydash(i,:), [], 2);
    y(i,index)=1;
end
return;

function [z ydash] = forwardpass(X, w, v)
% this function performs the forward pass on a set of data points in the
% variable X and returns the output of the hidden layer units- z and the
% output layer units ydash
% 'TO DO'
batchsize = size(X,1);
X=[ones(batchsize,1) X];
z=X*w';
z=tanh(z);
z=[ones(batchsize,1) z];
ydash=exp(z*v');
sumY = sum(ydash,2)*ones(1,10);
ydash = ydash./sumY;
return;

function [deltaw deltav] = computegradient(X, Y, w, v, z, ydash)
% this function computes the gradient of the error function with resepct to
% the weights
% 'TO DO'
batchsize = size(X,1);
X=[ones(batchsize,1) X];
deltaw=zeros(size(w));
deltav=zeros(size(v));
    del_3=ydash'-Y';
    del_2=(v'*del_3).*(1-(z'.*z'));
    del_2=del_2(2:end,:);
    deltaw=deltaw+(del_2*X);
    deltav=deltav+(del_3*z);
deltaw = deltaw./batchsize;
deltav = deltav./batchsize;

return;

function error = classerror(y, ydash)
% this function computes the classification error given the actual output y
% and the predicted output ydash

error = sum(sum(abs(y-ydash), 2)>0);
return;

function [h, display_array] = displayData(X)
% DO NOT CHANGE ANYTHING HERE
%DISPLAYDATA Display 2D data in a nice grid
%   [h, display_array] = DISPLAYDATA(X, example_width) displays 2D data
%   stored in X in a nice grid. It returns the figure handle h and the 
%   displayed array if requested.
%   example to plot the data provided by Andrew Ng.

% Set example_width automatically if not passed in
if ~exist('example_width', 'var') || isempty(example_width) 
	example_width = round(sqrt(size(X, 2)));
end

% Gray Image
colormap(gray);

% Compute rows, cols
[m n] = size(X);
example_height = (n / example_width);

% Compute number of items to display
display_rows = floor(sqrt(m));
display_cols = ceil(m / display_rows);

% Between images padding
pad = 1;

% Setup blank display
display_array = - ones(pad + display_rows * (example_height + pad), ...
                       pad + display_cols * (example_width + pad));

% Copy each example into a patch on the display array
curr_ex = 1;
for j = 1:display_rows
	for i = 1:display_cols
		if curr_ex > m, 
			break; 
		end
		% Copy the patch
		
		% Get the max value of the patch
		max_val = max(abs(X(curr_ex, :)));
		display_array(pad + (j - 1) * (example_height + pad) + (1:example_height), ...
		              pad + (i - 1) * (example_width + pad) + (1:example_width)) = ...
						reshape(X(curr_ex, :), example_height, example_width) / max_val;
		curr_ex = curr_ex + 1;
	end
	if curr_ex > m, 
		break; 
	end
end

% Display Image
h = imagesc(display_array, [-1 1]);

% Do not show axis
axis image off

drawnow;
return;
