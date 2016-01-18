function [rank_est, w] = CTC(y)
% CTC.m
%
% Categorical Triple Collocation (ETC) is a technique for estimating the
% relative performance rankings of three measurement systems (e.g.,
% satellite, in-situ and model-based products) based on their measurements
% of a binary/categorical variable with unknown true value (e.g., landscape
% freeze/thaw state). The performance ranking is with respect to
% the balanced accuracy metric.
%
% INPUTS
% y: an N x 3 matrix of temporally- and spatially-collocated observations 
% from the three measurement systems, where N is the sample size. This 
% must be the same for each measurement system. The values in y can be
% either 1 or -1. All NaNs must be removed.
%
% OUTPUTS
% rank_est: a 3 x 1 vector of the performance rankings of the measurement
% systems, with respect to their balanced accuracies. The ith row
% corresponds to the measurement system with observations in the ith column
% of y.
% w: a 3 x 1 vector, defined in Equation 14 of McColl et al. (2016), on
% which the performance rankings are based.
% 
% REFERENCE
% For more details on CTC, see:
%
% McColl, K.A., A. Roy, C. Derksen, A.G. Konings, S.H. Alemohammad, D.
% Entekhabi (2016). Triple collocation for binary and categorical
% variables: Application to validating landscape freeze/thaw retrievals.
% Remote Sensing of Environment (in press).
%
% If you use CTC, please cite this paper where appropriate.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% Author: Kaighin McColl
% Date: January 18, 2016

    % Catch errors in inputs
    if size(y,2) ~= 3
        error('Error: Input data y must be an N x 3 matrix');
    end
    
    if any(isnan(y(:)))
        error('Error: Input data y must not contain NaNs');
    end
    
    if any(y(:).^2~=1)
        error('Error: Input data y must contain only values 1 or -1');
    end
    
    if length(unique(y(:,1))) == 1 || length(unique(y(:,2))) == 1 || length(unique(y(:,3))) == 1 
        error('Error: the sample variance of each of the columns of y must be non-zero. Increase your sample size or reconsider using ETC.');
    end
    
    % Estimate covariance matrix of the three measurement systems
    Q_hat = cov(y);

    w = [sqrt(Q_hat(1,2)*Q_hat(1,3)/Q_hat(2,3)); 
        sqrt(Q_hat(1,2)*Q_hat(2,3)/Q_hat(1,3));
        sqrt(Q_hat(2,3)*Q_hat(1,3)/Q_hat(1,2))];
    
    % If w values are complex, display a warning.
    if any(~isreal(w))
        warning('Warning: at least one calculated w is complex. This can happen if the sample size is too small, or if one of the assumptions of CTC is violated.');
        rank_est = [NaN; NaN; NaN];
    else
        % otherwise, estimate the ranking
       [~,rank_est] = sort(w,1,'descend'); 
    end
    
end

