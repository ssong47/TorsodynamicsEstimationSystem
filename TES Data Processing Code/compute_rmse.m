function rmse = compute_rmse(estimate, ref)
% computes RMSE given reference and estimate

% find number of data points in the reference and estimate
N = min(length(estimate), length(ref));

% compute RMSE
rmse = sqrt(sum((estimate(1:N) - ref(1:N)).^2)/N);

end