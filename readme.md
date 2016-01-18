Categorical Triple Collocation (CTC)
=================================

Categorical Triple Collocation (CTC) is a technique for estimating the relative performance rankings of three measurement systems (e.g., satellite, in-situ and model-based products) based on their measurements of a binary/categorical variable with unknown true value (e.g., landscape freeze/thaw state). It is a variant of triple collocation for binary/categorical variables. See McColl et al. (2016) for more details (full reference below).

CTC.m is a Matlab function for implementing CTC.

## FAQ
### Why can't I use normal triple collocation for binary/categorical variables?
Binary and categorical variables are strongly bounded, inducing correlations between the error and truth that strongly violate the assumptions of triple collocation. CTC relaxes the assumptions of triple collocation to allow estimates of performance rankings of the three measurement systems, even with strong correlation between the errors and true values.

### Why am I getting an error message saying "at least one calculated w is complex"?
This can happen if your sample size is too small, causing the estimated covariance matrix Q_hat to be too noisy; or if one of the measurement systems used has a very low accuracy. It can also occur if one of the assumptions of CTC is violated. See McColl et al. (2016) for more details.


## Reference
If you publish work that uses this code, please cite:
>McColl, K.A., A. Roy, C. Derksen, A.G. Konings, S.H. Alemohammad, D. Entekhabi (2016). Triple collocation for binary and categorical variables: Application to validating landscape freeze/thaw retrievals. Remote Sensing of Environment (in press).

## Disclaimer
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.