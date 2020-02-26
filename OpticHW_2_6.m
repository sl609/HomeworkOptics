
n_s = 1.40;
n_b = 1.33;
n_rel = n_s/n_b;

Nx = 100;
Qs_all = zeros(Nx);
g_all = zeros(Nx);
Qs_all_rayleigh = zeros(Nx);
x_all = logspace(-1,3, Nx);

err = 1e-11;
for ix = 1:Nx
    x = x_all(ix);
    y = n_rel*x;

    % Calculate the summations
    Qs = 0;
    gQs = 0;
    for n = 1:100000
        Snx = sqrt(pi*x/2)*besselj(n+0.5,x);
        Sny = sqrt(pi*y/2)*besselj(n+0.5,y);
        Cnx = -sqrt(pi*x/2)*bessely(n+0.5,x);
        Zetax = Snx+i*Cnx;

        Snx_prime = - (n/x)*Snx+sqrt(pi*x/2)*besselj(n-0.5,x);
        Sny_prime = - (n/y)*Sny+sqrt(pi*y/2)*besselj(n-0.5,y);
        Cnx_prime = - (n/x)*Cnx-sqrt(pi*x/2)*bessely(n-0.5,x);
        Zetax_prime = Snx_prime + i*Cnx_prime;

        an_num = Sny_prime*Snx-n_rel*Sny*Snx_prime;
        an_den = Sny_prime*Zetax-n_rel*Sny*Zetax_prime;
        an = an_num/an_den;

        bn_num = n_rel*Sny_prime*Snx-Sny*Snx_prime;
        bn_den = n_rel*Sny_prime*Zetax-Sny*Zetax_prime;
        bn = bn_num/bn_den;

        Qs1 = (2*n+1)*(abs(an)^2+abs(bn)^2);
        Qs = Qs+Qs1;

        if n > 1
            gQs1 = (n-1)*(n+1)/n*real(an_1*conj(an)+bn_1*conj(bn))...
                +(2*n-1)/((n-1)*n)*real(an_1*conj(bn_1));
            gQs = gQs+gQs1;
        end

        an_1 = an;
        bn_1 = bn;

        if abs(Qs1)<(err*Qs) & abs(gQs1)<(err*gQs)
            {'ix = , n = ' ix, n}
            break;
        end
    end

    Qs = (2/x^2)*Qs;
    gQs = (4/x^2)*gQs;
    Qs_all(ix) = Qs;
    g_all(ix) = gQs/Qs;
    Qs_all_rayleigh(ix) = 8*x^4/3*abs((n_rel^2 - 1)/(n_rel^2 + 2))^2;
end

figure(1)

i_rayleigh = find(x_all<3);
loglog(x_all,Qs_all, 'k-', x_all(i_rayleigh), Qs_all_rayleigh(i_rayleigh), 'k:');
text(3, Qs_all_rayleigh(length(i_rayleigh)), 'Rayleigh theory')
ylim([10^-3,10])
xlim([10^-1,10^3])
xlabel('\itx = ka');
ylabel('Scattering efficiency \itQs');

figure(2)
semilogx(x_all,g_all, 'k-');
xlabel('\itx = ka');
ylabel('Anisotropy \itg');