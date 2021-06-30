abstract class ProviderForgetStat{}

class ProviderForgetInitState extends ProviderForgetStat{}

class ProviderForgetLoadingState extends ProviderForgetStat{}

class ProviderForgetSuccessState extends ProviderForgetStat{}

class ProviderForgetErrorState extends ProviderForgetStat{
  String error;
  ProviderForgetErrorState(this.error);
}