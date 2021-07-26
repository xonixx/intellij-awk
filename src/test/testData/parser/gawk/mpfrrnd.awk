BEGIN {
	N = 22/7
	printf("   %.15f\n", N)

	printf("*  %.10f\n", N)	# default
	ROUNDMODE="N"; printf("N  %.10f\n", N)
	ROUNDMODE="U"; printf("U  %.10f\n", N)
	ROUNDMODE="D"; printf("D  %.10f\n", N)
	ROUNDMODE="Z"; printf("Z  %.10f\n", N)
	N = -N
	ROUNDMODE="N"; printf("N %.10f\n", N)
	ROUNDMODE="U"; printf("U %.10f\n", N)
	ROUNDMODE="D"; printf("D %.10f\n", N)
	ROUNDMODE="Z"; printf("Z %.10f\n", N)
}
